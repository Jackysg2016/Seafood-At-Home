//
//  HomeViewController.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "HomeViewController.h"
#import "DetailNormalViewController.h"
#import "TypeListViewController.h"
#import "SFAPILoader.h"
#import "HomeKeyModel.h"
#import "SFVCProtocol.h"

static NSString * const kSeparateLineImageNamed = @"home_separate_line";
static NSString * const kReadyForYouImageNamed = @"ready_for_you";

@interface HomeViewController ()<SFVCProtocol> {
    TryHaiTaoScrollView *_tryHaiTaoScrollView;
    BWMCoverView *_coverView;
    UIImageView *_tenRMBBanner;
    TypeCoverImageScrollView *_typeCoverImageScrollView;
    UIImageView *_separateLineImageView;
    UIImageView *_readyForYouImageView;
    HomeMiddleProductListView *_choicenessListView;
    HomeMiddleProductListView *_comboListView;
    HomeFooterHelperView *_homeFooterHelperView;
    
    HomeKeyModel *_homeModel;
}
@end

@implementation HomeViewController

#pragma mark-
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSlidingMenuButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    [self initializationTableView];
    [self createUI];
    
    __weak __typeof(&*self)vc = self;
    [SFAPILoader getWithURL1:[API APIOfHome] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [vc analysisDataWithResponseDict:responseDict];
    } failed:nil];
    [self.tableView addHeaderWithCallback:^{
        [SFAPILoader getWithURL3:[API APIOfHome] targetVC:vc finished:^(NSURLResponse *response, NSDictionary *responseDict) {
            [vc analysisDataWithResponseDict:responseDict];
            [vc.tableView headerEndRefreshing];
        } failed:^(NSURLResponse *response, NSError *error) {
            [vc.tableView headerEndRefreshing];
        }];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_coverView resetCoverView];
}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    _homeModel = [[HomeKeyModel alloc] initWithDictionary:responseDict[@"result"]];
    
//    // 更新顶部try海淘
//    NSMutableArray *imagesURL = [[NSMutableArray alloc] init];
//    for (HomeCoverModel *model in _homeModel.coverArray) {
//        [imagesURL addObject:model.imageURL];
//    }
//    _tryHaiTaoScrollView.imageURLArray = imagesURL;
    
    // 更新CoverView
    NSMutableArray *tempArray1 = [[NSMutableArray alloc] init];
    for (HomeCoverModel *model in _homeModel.coverArray) {
        BWMCoverViewModel *theModel = [BWMCoverViewModel coverViewModelWithImageURLString:model.imageURL.absoluteString];
        [tempArray1 addObject:theModel];
    }
    _coverView.models = tempArray1;
    [_coverView updateView];
    
    // 更新Banner
    [_tenRMBBanner sd_setImageWithURL:_homeModel.ADBannerModel.imageURL placeholderImage:WAIT_LOADING_IMAGE];
    
    // 更新热门子类
    NSMutableArray *tempArray2 = [[NSMutableArray alloc] init];
    for (HomeBreedModel *model in _homeModel.breedArray) {
        [tempArray2 addObject:model.imageURL];
    }
    _typeCoverImageScrollView.imagesURL = tempArray2;
    
    // 更新精选单品
    _choicenessListView.models = _homeModel.hotProductArray;
    
    // 更新套餐
    _comboListView.models = _homeModel.happyComboArray;
}

- (void)createUI {
    //    _tryHaiTaoScrollView = [TryHaiTaoScrollView tryHaiTaoScrollViewWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 48.0)  imageURLArray:nil delegate:self];
    
    _coverView = [BWMCoverView coverViewWithModels:nil andFrame:CGRectMake(0.0, 0.0, VIEW_SIZE.width, AUTO_MATE_WIDTH(185.0f)) andPlaceholderImageNamed:@"coming_soon" andImageViewsContentMode:UIViewContentModeScaleAspectFill andClickdCallBlock:^(int index) {
        HomeCoverModel *model = _homeModel.coverArray[index];
        DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID];
        [self.navigationController pushViewController:vc animated:YES];
    } andScrolledCallBlock:nil];
    [_coverView setAutoPlayWithDelay:3.0f];
    
    _tenRMBBanner = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 45.0)];
    _tenRMBBanner.contentMode = UIViewContentModeScaleAspectFill;
    _tenRMBBanner.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tenRMBBannerTap:)];
    [_tenRMBBanner addGestureRecognizer:tap];
    
    _typeCoverImageScrollView = [TypeCoverImageScrollView typeCoverImageScrollViewWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 184.1) imagesURL:nil delegate:self];
    
    _separateLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 35)];
    _separateLineImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kSeparateLineImageNamed]];
    
    _readyForYouImageView = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_SIZE.width-213)/2.0, 0, 213, 65)];
    _readyForYouImageView.image = [UIImage imageNamed:kReadyForYouImageNamed];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, ON_VIEW_BOTTOM(_readyForYouImageView, 5), VIEW_SIZE.width, 2)];
    line.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
    
    _choicenessListView = [HomeMiddleProductListView homeMiddleProductListViewWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 165) listType:HomeMiddleProductListTypeChoiceness models:nil leftText:@"精选单品" rightText:@"进入单品专区" delegate:self];
    
    _comboListView = [HomeMiddleProductListView homeMiddleProductListViewWithFrame:CGRectMake(0, 0, VIEW_SIZE.width, 150) listType:HomeMiddleProductListTypeCombo models:nil leftText:@"欢乐套餐" rightText:@"开启欢乐派对" delegate:self];
    
    _homeFooterHelperView = [HomeFooterHelperView homeFooterHelperViewWithFrame:CGRectMake((VIEW_SIZE.width-320)/2.0, 0, 320, 270.0)];
}

// 10元风暴Banner点击事件
- (void)tenRMBBannerTap:(UITapGestureRecognizer *)recognizer {
    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(_homeModel.ADBannerModel.remark)];
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=16&index=", APIName, _homeModel.ADBannerModel.breedID];
    TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:_homeModel.ADBannerModel.remark];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * const cellIdentity = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentity];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    // clearAllView
    for (UIView *subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:_tryHaiTaoScrollView];
            break;
        case 1:
            [cell.contentView addSubview:_coverView];
            break;
        case 2:
            [cell.contentView addSubview:_tenRMBBanner];
            break;
        case 3:
            [cell.contentView addSubview:_typeCoverImageScrollView];
            break;
        case 4:
            [cell.contentView addSubview:_separateLineImageView];
            break;
        case 5:
            [cell.contentView addSubview:_readyForYouImageView];
            break;
        case 6:
            [cell.contentView addSubview:_choicenessListView];
            break;
        case 7:
            [cell.contentView addSubview:_comboListView];
            break;
        case 8:
            [cell.contentView addSubview:_homeFooterHelperView];
            break;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    float height = 0.0;
    switch (indexPath.row) {
        case 0:
            height = _tryHaiTaoScrollView.height;
            break;
        case 1:
            height = AUTO_MATE_WIDTH(185.0f) + 5;
            break;
        case 2:
            height = _tenRMBBanner.height + 5;
            break;
        case 3:
            height = _typeCoverImageScrollView.height + 5;
            break;
        case 4:
            height = _separateLineImageView.height + 15;
            break;
        case 5:
            height = _readyForYouImageView.height + 2;
            break;
        case 6:
            height = _choicenessListView.height;
            break;
        case 7:
            height = _comboListView.height;
            break;
        case 8:
            height = _homeFooterHelperView.height;
            break;
    }
    return height;
}

#pragma mark- TryHaiTaoScrollViewDelegate
- (void)tryHaiTaoScrollView:(TryHaiTaoScrollView *)tryHaiTaoScrollView clickedIndex:(int)clickedIndex {
    HomeCoverModel *model = _homeModel.coverArray[clickedIndex];
    DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- TypeCoverImageScrollViewDelegate

- (void)typeCoverImageScrollView:(TypeCoverImageScrollView *)typeCoverImageScrollView clickedIndex:(int)clickedIndex {
    HomeBreedModel *model = _homeModel.breedArray[clickedIndex];
    NSString *APIName = [SFAPILoader remarkTypeDictionary][@(model.remark)];
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=16&index=", APIName, model.breedID];
    NSLog(@"%@", APIFormat);
    TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:model.remark];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- HomeMiddleProductListViewDelegate
- (void)homeMiddleProductListView:(HomeMiddleProductListView *)listView clickedIndex:(int)clickedIndex {
    if (_choicenessListView == listView) {
        HomeMiddleProductListViewModel *model = _homeModel.hotProductArray[clickedIndex];
        DetailNormalViewController *vc = [[DetailNormalViewController alloc] initWithProductID:model.productID];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (_comboListView == listView) {
        HomeMiddleProductListViewModel *model = _homeModel.happyComboArray[clickedIndex];
        NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ComboList&breedid=%d&size=16&index=", model.breedID];
        TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:RemarkSymbolTypeCombo];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)homeMiddleProductListView:(HomeMiddleProductListView *)listView rightLabelTap:(UILabel *)rightLabel {
    if (_choicenessListView == listView) {
        NSString *APIFormat = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=HotList&size=16&index=";
        TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:RemarkSymbolTypeHotProducts];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (_comboListView == listView) {
        NSString *APIFormat = @"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ComboList&Categoryid=9&size=16&index=";
        TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:RemarkSymbolTypeCombo];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end