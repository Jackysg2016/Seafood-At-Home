//
//  DetailComboViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "DetailComboViewController.h"
#import "ProductListCollectionView.h"
#import "SFAPILoader.h"
#import "SVProgressHUD.h"
#import "WTRequestCenter.h"
#import "SIAlertView.h"
#import "SFUserDefaults.h"
#import "UserPrefixNavController.h"
#import "DetailNormalViewController.h"
#import "ShoppingCarAddShopCarModel.h"
#import "ReviewModel.h"

@interface DetailComboViewController() <ProductListCollectionViewDelegate>
{
    ProductListCollectionView *_collectionView;
}
@end

@implementation DetailComboViewController

- (instancetype)initWithModel:(ListAndDetailModel *)model {
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    [self.UIHelper appendingNavTitleWithString:_model.cnTitle];
    [self createUI];
}

- (void)createUI {
    _collectionView = [[ProductListCollectionView alloc] initWithFrame:ROOT_VIEW_FRMAE delegate:self canShowHeaderView:YES showButton:NO];
    [self.view addSubview:_collectionView];
    _collectionView.dataArray = @[self.model];
}

#pragma mark- ProductListCollectionViewDelegate

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedBuyButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    
    [SVProgressHUD showWithStatus:@"请稍后" maskType:SVProgressHUDMaskTypeClear];
    ShoppingCarAddShopCarModel *addShopCarModel = [[ShoppingCarAddShopCarModel alloc] init];
    if (_model.saleID != NSNotFound) {
        addShopCarModel.productID = _model.saleID;
    } else {
        addShopCarModel.productID = _model.productID;
    }
    addShopCarModel.isPorc = _model.isPorc;
    addShopCarModel.remark = _remark;
    [WTRequestCenter postWithURL:[ShoppingCarAddShopCarModel API] parameters:[addShopCarModel postDictionary] finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDict = JSON_TO_DICT(data);
        SIAlertView *alertView = [[SIAlertView alloc] init];
        alertView.title = @"温馨提示";
        if([responseDict[@"ret"] intValue] == 0) {
            alertView.message = @"添加到购物篮成功！";
            // 更新UserDefaults
            [[SFUserDefaults sharedUserDefaults] shoppingCarCountAscending];
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
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedLoveButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self reviewWithType:ReviewTypeLike];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedUnloveButton:(UIButton *)button index:(int)index {
    if (![[SFUserDefaults sharedUserDefaults] isLogined]) {
        UserPrefixNavController *nav = [[UserPrefixNavController alloc] init];
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self reviewWithType:ReviewTypeDislike];
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
    NSString *API = [ReviewModel APIWithReviewType:reviewType productID:_model.productID isCombo:_model.isPorc];
    [WTRequestCenter getWithURL:API parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *responseDict = JSON_TO_DICT(data);
        if ([responseDict[@"ret"] intValue] == 0) {
            ReviewModel *reviewModel = [[ReviewModel alloc] initWithDictionary:responseDict[@"result"]];
            _model.loveCount = reviewModel.likeCount;
            _model.unloveCount = reviewModel.dislikeCount;
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
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
    ListAndDetailComboItemModel *itemModel = _model.itemsArray[indexPath.row];
    DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:itemModel.productID remark:_remark];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
