//
//  BrandViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "BrandViewController.h"
#import <MediaPlayer/MPMoviePlayerViewController.h>
#import "TypeListViewController.h"
#import "DetailNormalViewController.h"
#import "BrandGoodProductCollectionView.h"
#import "BrandKeyModel.h"
#import "BrandComboItemView.h"
#import "SFAPILoader.h"
#import "BWMMoviewPlayerViewController.h"
#import "SFVCProtocol.h"

@interface BrandViewController () <BrandGoodProductCollectionViewDelegate, SFVCProtocol> {
    IBOutlet UIImageView *_videoImageView;
    IBOutlet UILabel *_headerTitle;
    IBOutlet UILabel *_headerDetail;
    IBOutlet UILabel *_middleTitle;
    IBOutlet UILabel *_middleSubTitle;
    IBOutlet UILabel *_middleDetail;
    IBOutlet UILabel *_footerTitle;
    IBOutlet UILabel *_footerSubTitle;
    IBOutlet UILabel *_footerDetail;
    IBOutlet BrandGoodProductCollectionView *_goodProductCollectionView;
    IBOutlet iCarousel *_myCarousel;
    
    BrandKeyModel *_brandModel;
}
@end

@implementation BrandViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSlidingMenuButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, 1933)];
    [self createUI];
    [self createData];
}

- (void)createUI {
    _goodProductCollectionView.targetDelegate = self;
    _videoImageView.clipsToBounds = YES;
    _myCarousel.type = iCarouselTypeCoverFlow2;
    _myCarousel.delegate = self;
    _myCarousel.dataSource = self;
    
    [self.scrollView addHeaderWithTarget:self action:@selector(refreshData)];
}

- (void)createData {
    [SFAPILoader getWithURL1:[BrandKeyModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
}

- (void)refreshData {
    [SFAPILoader getWithURL3:[BrandKeyModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self.scrollView headerEndRefreshing];
    }];
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    [self.scrollView headerEndRefreshing];
    _brandModel = [[BrandKeyModel alloc] initWithDictionary:responseDict[@"result"]];
    [_videoImageView sd_setImageWithURL:_brandModel.videoModel.imageURL  placeholderImage:WAIT_LOADING_IMAGE];
    
    _headerTitle.text = _brandModel.headerModel.title;
    _headerDetail.text = _brandModel.headerModel.subTitle;
    
    _middleTitle.text = _brandModel.middleModel.title;
    _middleSubTitle.text = _brandModel.middleModel.subTitle;
    _middleDetail.text = _brandModel.middleModel.detail;
    
    _footerTitle.text = _brandModel.footerModel.title;
    _footerSubTitle.text = _brandModel.footerModel.subTitle;
    _footerDetail.text = _brandModel.footerModel.detail;
    
    [_goodProductCollectionView updateWithModelsArray:_brandModel.excellenceProductArray];
    [_myCarousel reloadData];
}

// 播放按钮点击事件
- (IBAction)playBtnClicked:(UIButton *)sender {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:_brandModel.videoModel.videoURL];
        [self presentMoviePlayerViewControllerAnimated:vc];
    } else {
        BWMMoviewPlayerViewController *player = [[BWMMoviewPlayerViewController alloc] initWithContentURL:_brandModel.videoModel.videoURL];
        [self presentViewController:player animated:YES completion:nil];
    }
}

#pragma mark- iCarouselDelegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel {
    return _brandModel.characteristicComboArray.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    BrandComboItemView *itemView = (BrandComboItemView *)view;
    if (!itemView) {
        itemView = [BrandComboItemView view];
        itemView.frame = CGRectMake(0, 0, 160, 215);
    }
    BrandCharacteristicComboModel *model = _brandModel.characteristicComboArray[index];
    [itemView updateWithModel:model];
    return itemView;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index {
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ComboList&index="];
    TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:RemarkSymbolTypeCombo];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- BrandGoodProductCollectionViewDelegate
- (void)collectionView:(BrandGoodProductCollectionView *)collectionView didSelectItemAtIndex:(int)index {
    BrandExcellenceProductModel *model = _brandModel.excellenceProductArray[index];
    DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID remark:RemarkSymbolTypeRecommend];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
