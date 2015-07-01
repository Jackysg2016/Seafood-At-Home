//
//  TypeListViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/7.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TypeListViewController.h"
#import "MainViewTypeTableHeaderView.h"
#import "UserPrefixNavController.h"
#import "ProductListCollectionView.h"
#import "SFUserDefaults.h"
#import "DetailNormalViewController.h"
#import "SFAPILoader.h"
#import "TypeViewModel.h"
#import "ShoppingCarAddShopCarModel.h"
#import "ReviewModel.h"
#import "SIAlertView.h"
#import "WTRequestCenter.h"
#import "SVProgressHUD.h"
#import "SFVCProtocol.h"

@interface TypeListViewController ()
<
    ProductListCollectionViewDelegate,
    SFVCProtocol
>
{
    ProductListCollectionView *_collectionView;
    NSMutableArray *_dataArray;
    int _pageIndex;
}
@end

@implementation TypeListViewController

- (instancetype)initWithAPIFormat:(NSString *)APIFormat remark:(RemarkSymbolType)remark {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
        self.APIFormat = APIFormat;
        self.remark = remark;
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    if ([_APIFormat rangeOfString:@"ProductName"].location == NSNotFound) {
        [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    } else {
        [self.UIHelper appendingNavTitleWithString:[NSString stringWithFormat:@"搜索：%@", _searchKey]];
    }
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    [self createUI];
    [self createData];
}

- (void)createUI {
    BOOL isShowButton = NO;
    if (RemarkSymbolTypeHotProducts == _remark || RemarkSymbolTypeProducts == _remark) {
        isShowButton = YES;
    }
    _collectionView = [[ProductListCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height - 64) delegate:self canShowHeaderView:YES showButton:isShowButton];
    [self.view addSubview:_collectionView];
    
    // 加载更多和刷新
    [_collectionView.collectionView addHeaderWithTarget:self action:@selector(refreshData)];
    [_collectionView.collectionView addFooterWithTarget:self action:@selector(loadMore)];
}

- (void)createData {
    _pageIndex = 1;
    NSString *api = [NSString stringWithFormat:@"%@%d", self.APIFormat, _pageIndex];
    [SFAPILoader getWithURL1:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
}

- (void)refreshData {
    _pageIndex = 1;
    NSString *api = [NSString stringWithFormat:@"%@%d", self.APIFormat, _pageIndex];
    [SFAPILoader getWithURL3:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [_dataArray removeAllObjects];
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [_collectionView.collectionView headerEndRefreshing];
    }];
}

- (void)loadMore {
    _pageIndex ++;
    NSString *api = [NSString stringWithFormat:@"%@%d", self.APIFormat, _pageIndex];
    [SFAPILoader getWithURL2:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [_collectionView.collectionView footerEndRefreshing];
    }];
    NSLog(@"%@", api);
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    for (int i = 0; i<[responseDict[@"result"] count]; i++) {
        NSDictionary *theDict = [responseDict[@"result"] objectAtIndex:i];
        ListAndDetailModel *model = [ListAndDetailModel modelWithDictionary:theDict];
        [_dataArray addObject:model];
    }
    _collectionView.dataArray = [_dataArray copy];
    
    [_collectionView.collectionView footerEndRefreshing];
    [_collectionView.collectionView headerEndRefreshing];
}

#pragma mark- ProductListCollectionViewDelegate

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedItemIndex:(int)index {
    ListAndDetailModel *model = _dataArray[index];
    if (!model.isPorc) {
        DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID remark:_remark];
        vc.saleID = model.saleID; // 修复Bug
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedBuyButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    ListAndDetailModel *listModel = [_dataArray objectAtIndex:index];
    [SVProgressHUD showWithStatus:@"请稍后" maskType:SVProgressHUDMaskTypeClear];
    ShoppingCarAddShopCarModel *addShopCarModel = [[ShoppingCarAddShopCarModel alloc] init];
    if (listModel.saleID != NSNotFound) {
        addShopCarModel.productID = listModel.saleID;
    } else {
        addShopCarModel.productID = listModel.productID;
    }
    addShopCarModel.isPorc = listModel.isPorc;
    addShopCarModel.remark = _remark;
    [WTRequestCenter postWithURL:[ShoppingCarAddShopCarModel API] parameters:[addShopCarModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDict = JSON_TO_DICT(data);
        SIAlertView *alertView = [[SIAlertView alloc] init];
        alertView.title = @"温馨提示";
        if([responseDict[@"ret"] intValue] == 0) {
            alertView.message = @"添加到购物篮成功！";
            // 更新UserDefaults
            [[SFUserDefaults sharedUserDefaults] requestNetworkingShoppingCarCount];
        } else {
            alertView.message = responseDict[@"msg"];
        }
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeDestructive handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView show];
        [SVProgressHUD dismiss];
    } failed:^(NSURLResponse *response, NSError *error) {
        SIAlertView *alertView = [[SIAlertView alloc] init];
        alertView.title = @"温馨提示";
        alertView.message = @"由于网络故障，添加到购物篮失败！";
        [alertView addButtonWithTitle:@"确定" type:SIAlertViewButtonTypeCancel handler:nil];
        [alertView setTransitionStyle:SIAlertViewTransitionStyleBounce];
        [alertView show];
        [SVProgressHUD dismiss];
    }];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedLoveButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self reviewWithType:ReviewTypeLike index:index];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedUnloveButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self reviewWithType:ReviewTypeDislike index:index];
}

- (void)reviewWithType:(ReviewType)reviewType index:(int)index {
    [SVProgressHUD showWithStatus:@"请稍后..." maskType:SVProgressHUDMaskTypeClear];
    NSString *successMsg = nil;
    NSString *errorMsg = nil;
    if (ReviewTypeLike == reviewType) {
        successMsg = @"点赞成功！";
        errorMsg = @"由于网络原因点赞失败！";
    } else {
        successMsg = @"踩踩成功！";
        errorMsg = @"由于网络原因踩踩失败！";
    }
    ListAndDetailModel *listModel = _dataArray[index];
    NSString *API = [ReviewModel APIWithReviewType:reviewType productID:listModel.productID isCombo:listModel.isPorc];
    NSLog(@"%@", API);
    [WTRequestCenter getWithURL:API parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDict = JSON_TO_DICT(data);
        NSLog(@"%@", responseDict);
        if ([responseDict[@"ret"] intValue] == 0) {
            ReviewModel *reviewModel = [[ReviewModel alloc] initWithDictionary:responseDict[@"result"]];
            listModel.loveCount = reviewModel.likeCount;
            listModel.unloveCount = reviewModel.dislikeCount;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
            [_collectionView.collectionView reloadItemsAtIndexPaths:@[indexPath]];
            [SVProgressHUD showSuccessWithStatus:successMsg];
        } else {
            [SVProgressHUD showErrorWithStatus:responseDict[@"msg"]];
        }
    } failed:^(NSURLResponse *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView comboProductClickedIndexPath:(NSIndexPath *)indexPath {
    ListAndDetailModel *model = _dataArray[indexPath.section];
    ListAndDetailComboItemModel *itemModel = model.itemsArray[indexPath.row];
    DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:itemModel.productID];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
