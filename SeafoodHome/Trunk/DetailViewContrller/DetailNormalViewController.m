//
//  DetailViewController.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailNormalViewController.h"
#import "UserPrefixNavController.h"
#import "SFAPILoader.h"
#import "SIAlertView.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "ShoppingCarAddShopCarModel.h"
#import "SFUserDefaults.h"
#import "ReviewModel.h"
#import "SFVCProtocol.h"

@interface DetailNormalViewController () <SFVCProtocol> {
    DetailCollectionView *_collectionView;
    DetailMainCollectionViewCellModel *mainModel;
    MWPhotoBrowser *_photoBrower;
}
@end

@implementation DetailNormalViewController

- (instancetype)initWithProductID:(int)productID remark:(RemarkSymbolType)remark {
    self = [self initWithProductID:productID];
    self.remark = remark;
    return self;
}

- (instancetype)initWithProductID:(int)productID {
    self = [self init];
    self.productID = productID;
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        self.saleID = NSNotFound;
        self.isShowShoppingCarButton = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createUI];
    [self createData];
}

- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.UIHelper appendingNavTitleWithString:@"正在努力加载中..."];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    if (_isShowShoppingCarButton)
        [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    _collectionView = [DetailCollectionView detailCollectionViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NavigationBar_HEIGHT) delegate:self];
    [self.view addSubview:_collectionView];
    [_collectionView.collectionView addHeaderWithTarget:self action:@selector(refreshData)];
    
    if (!_photoBrower) {
        _photoBrower = [[MWPhotoBrowser alloc] initWithDelegate:self];
        [_photoBrower showNextPhotoAnimated:YES];
        [_photoBrower showPreviousPhotoAnimated:YES];
    }
}

- (void)refreshData {
    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectProductorDetail&productid=%d&remarkid=%d", _productID, (int)_remark];
    [SFAPILoader getWithURL3:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDictionary:responseDict];
        [_collectionView.collectionView headerEndRefreshing];
    } failed:^(NSURLResponse *response, NSError *error) {
        [_collectionView.collectionView headerEndRefreshing];
    }];
}

#pragma mark-
- (void)createData {
    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=SelectProductorDetail&productid=%d", _productID];
    [SFAPILoader getWithURL1:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        NSString *title = [responseDict[@"result"] objectForKey:@"app_cnTitle"];
        [self.UIHelper appendingNavTitleWithString:title];
        [self analysisDataWithResponseDictionary:responseDict];
    } failed:nil];
}

- (void)analysisDataWithResponseDictionary:(NSDictionary *)responseDictionary {
    mainModel = [DetailMainCollectionViewCellModel modelWithDictionary:responseDictionary[@"result"]];
    _collectionView.mainModel = mainModel;
    [_photoBrower reloadData];
}

#pragma mark- DetailCollectionViewDelegate
- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView buttonClickedType:(DetailMainCollectionViewCellButtonType)type {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    if (DetailMainCollectionViewCellButtonTypeBuy == type) {
        [SVProgressHUD showWithStatus:@"请稍后" maskType:SVProgressHUDMaskTypeClear];
        ShoppingCarAddShopCarModel *model = [[ShoppingCarAddShopCarModel alloc] init];
        
        if (self.saleID != NSNotFound) {
            model.productID = self.saleID;
        } else {
            model.productID = mainModel.productID;
        }
        model.isPorc = NO;
        model.remark = _remark;
        [WTRequestCenter postWithURL:[ShoppingCarAddShopCarModel API] parameters:[model postDictionary] finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *responseDict = JSON_TO_DICT(data);
            SIAlertView *alertView = [[SIAlertView alloc] init];
            alertView.title = @"温馨提示";
            if([responseDict[@"ret"] intValue] == 0) {
                alertView.message = @"添加到购物篮成功！";
                // 更新UserDefaults
                [[SFUserDefaults sharedUserDefaults] requestNetworkingShoppingCarCount];
            } else {
                alertView.message = @"添加到购物篮失败！";
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

    } else if (DetailMainCollectionViewCellButtonTypeLove == type) {
        [self reviewWithType:ReviewTypeLike];
    } else if (DetailMainCollectionViewCellButtonTypeUnlove == type) {
        [self reviewWithType:ReviewTypeDislike];
    }
}

- (void)reviewWithType:(ReviewType)reviewType {
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
    NSString *API = [ReviewModel APIWithReviewType:reviewType productID:mainModel.productID isCombo:mainModel.isPorc];
    [WTRequestCenter getWithURL:API parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDict = JSON_TO_DICT(data);
        if ([responseDict[@"ret"] intValue] == 0) {
            ReviewModel *reviewModel = [[ReviewModel alloc] initWithDictionary:responseDict[@"result"]];
            mainModel.loveCount = reviewModel.likeCount;
            mainModel.unloveCount = reviewModel.dislikeCount;
            [_collectionView.collectionView reloadData];
            [SVProgressHUD showSuccessWithStatus:successMsg];
        } else {
            [SVProgressHUD showErrorWithStatus:responseDict[@"msg"]];
        }
    } failed:^(NSURLResponse *response, NSError *error) {
        [SVProgressHUD showErrorWithStatus:errorMsg];
    }];
}


- (void)detailCollectionViewMoreButtonClicked:(DetailCollectionView *)detailCollectionView {
//    SFWebViewController *vc = [[SFWebViewController alloc] initWithHTMLString:mainModel.descHTMLText];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView hexagramImageViewTaped:(HexagramImageView *)imageView {
    [_photoBrower setCurrentPhotoIndex:0];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_photoBrower];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)detailCollectionView:(DetailCollectionView *)detailCollectionView itemClickedAtIndex:(int)index {
    [_photoBrower setCurrentPhotoIndex:index];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_photoBrower];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark- MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return mainModel.imagesURLArray.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    NSURL *url = mainModel.imagesURLArray[index];
    MWPhoto *photo = [MWPhoto photoWithURL:url];
    photo.caption = [NSString stringWithFormat:@"%@ %@", mainModel.cnTitle, mainModel.enTitle];
    return photo;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    NSURL *url = mainModel.imagesURLArray[index];
    MWPhoto *photo = [MWPhoto photoWithURL:url];
    return photo;
}

@end