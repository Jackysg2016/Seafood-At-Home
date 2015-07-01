//
//  TypeProgressViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TypeProgressViewController.h"
#import "MainViewTypeTableHeaderView.h"
#import "MainTypeViewMenuCell.h"
#import "ProductListCollectionView.h"
#import "SubTypeModel.h"
#import "SFAPILoader.h"
#import "ListAndDetailModel.h"
#import "TypeListViewController.h"
#import "SFVCProtocol.h"

static NSString * const kCellIdentity = @"MainTypeViewMenuCell";

@interface TypeProgressViewController() <ProductListCollectionViewDelegate, SFVCProtocol>
{
    MainViewTypeTableHeaderView *_headerView;
    ProductListCollectionView *_collectionView;
    UITableView *_leftTableView;
    
    NSMutableArray *_rightDataArray;
    int _pageNumber;
}
@end

/** 小类的选择过程视图控制器 */
@implementation TypeProgressViewController

- (instancetype)initWithSubTypeArray:(NSArray *)subTypeArray selectedSubTypeModel:(SubTypeModel *)selectedSubTypeModel {
    if (self = [super init]) {
        self.subTypeArray = subTypeArray;
        self.selectedSubTypeModel = selectedSubTypeModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavTitleWithString:_selectedSubTypeModel.subTypeName];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];

    [self createUI];
    [self createData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_collectionView scrollToTop];
}

- (void)createUI {
    _headerView = [[MainViewTypeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [MainViewTypeTableHeaderView height])];
    [_headerView hideButtons];
    [self.view addSubview:_headerView];
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.height-2, self.view.width/2.0-4, self.view.height-_headerView.height-NavigationBar_HEIGHT-STATUSBAR_HEIGHT) style:UITableViewStylePlain];
    _leftTableView.backgroundColor = [UIColor clearColor];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorInset = UIEdgeInsetsZero;
    _leftTableView.showsVerticalScrollIndicator = NO;
    [_leftTableView registerNib:NIB_NAMED([MainTypeViewMenuCell class]) forCellReuseIdentifier:kCellIdentity];
    [self.view addSubview:_leftTableView];
    
    BOOL showButton = NO;
    if (_selectedSubTypeModel.remark == RemarkSymbolTypeProducts || _selectedSubTypeModel.remark == RemarkSymbolTypeHotProducts) {
        showButton = YES;
    }
    _collectionView = [[ProductListCollectionView alloc] initWithFrame:CGRectMake(self.view.width/2.0+4, _headerView.height-2, self.view.width/2.0-4, self.view.height-_headerView.height-NavigationBar_HEIGHT-STATUSBAR_HEIGHT+2)  delegate:self canShowHeaderView:NO showButton:showButton];
    _collectionView.isForceGridStyle = YES;
    [self.view addSubview:_collectionView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(collectionViewTaped:)];
    [_collectionView addGestureRecognizer:tap];
    
    UIView *yellowLine = [[UIView alloc] initWithFrame:CGRectMake(_leftTableView.width, _headerView.height-2, 8.0, 1000)];
    yellowLine.backgroundColor = MAIN_YELLOW_COLOR;
    [self.view addSubview:yellowLine];
}

// 轻敲CollectionView会跳动到最详细的页面
- (void)collectionViewTaped:(UITapGestureRecognizer *)recognizer {
    [self pushViewControllerToDetailViewController];
}

- (void)pushViewControllerToDetailViewController {
    RemarkSymbolType remark = _selectedSubTypeModel.remark;
    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(remark)];
    int breedID = _selectedSubTypeModel.subTypeID;
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=16&index=", APIName, breedID];
    NSLog(@"APIFormat ： %@", APIFormat);
    TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:remark];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)createData {
    _rightDataArray = [[NSMutableArray alloc] init];
    _pageNumber = 1;
    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(_selectedSubTypeModel.remark)];
    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=2&index=%d", APIName, _selectedSubTypeModel.subTypeID, _pageNumber];
    [SFAPILoader getWithURL1:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        [self analysisDataWithResponseDict:responseDict];
    } failed:nil];
    
//    [_collectionView.collectionView addHeaderWithTarget:self action:@selector(refreshData)];
//    [_collectionView.collectionView addFooterWithTarget:self action:@selector(loadMore)];
}
//
//- (void)refreshData {
//    _pageNumber = 1;
//    [_rightDataArray removeAllObjects];
//    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(_selectedSubTypeModel.remark)];
//    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=1&index=%d", APIName, _selectedSubTypeModel.subTypeID, _pageNumber];
//    [SFAPILoader getWithURL3:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
//        [self analysisDataWithDictionary:responseDict];
//    } failed:^(NSURLResponse *response, NSError *error) {
//        [_collectionView.collectionView headerEndRefreshing];
//    }];
//}

//- (void)loadMore {
//    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(_selectedSubTypeModel.remark)];
//    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=1&index=%d", APIName, _selectedSubTypeModel.subTypeID, _pageNumber];
//    [SFAPILoader getWithURL2:api targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
//        [self analysisDataWithDictionary:responseDict];
//    } failed:^(NSURLResponse *response, NSError *error) {
//        [_collectionView.collectionView footerEndRefreshing];
//    }];
//    _pageNumber++;
//}

- (void)analysisDataWithResponseDict:(NSDictionary *)responseDict {
    for (NSDictionary *dict in responseDict[@"result"]) {
        ListAndDetailModel *model = [[ListAndDetailModel alloc] initWithDictionary:dict];
        [_rightDataArray addObject:model];
    }
    _collectionView.dataArray = [_rightDataArray copy];
    
    [_collectionView.collectionView footerEndRefreshing];
    [_collectionView.collectionView headerEndRefreshing];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _subTypeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTypeViewMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    SubTypeModel *model = _subTypeArray[indexPath.row];
    [cell updateCellWithTitle:model.subTypeName];
    if (_selectedSubTypeModel == model) {
        [tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        [cell selectedStatus];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTypeViewMenuCell *cell = (MainTypeViewMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell selectedStatus];
    _selectedSubTypeModel = _subTypeArray[indexPath.row];
    [self.UIHelper appendingNavTitleWithString:_selectedSubTypeModel.subTypeName];
    
    NSString *APIName = [[SFAPILoader remarkTypeDictionary] objectForKey:@(_selectedSubTypeModel.remark)];
    NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&breedid=%d&size=2&index=%d", APIName, _selectedSubTypeModel.subTypeID, _pageNumber];
    [SFAPILoader loadDataWithURLString:api delegate:self success:^(NSURLResponse *response, NSDictionary *dict) {
        [_rightDataArray removeAllObjects];
        for (NSDictionary *dictionary in dict[@"result"]) {
            ListAndDetailModel *model = [[ListAndDetailModel alloc] initWithDictionary:dictionary];
            [_rightDataArray addObject:model];
        }
        _collectionView.userInteractionEnabled = YES;
        _collectionView.dataArray = _rightDataArray;
//        [_collectionView scrollToTop];
    } error:^(void){
        _collectionView.dataArray = nil;
        _collectionView.userInteractionEnabled = NO;
    } finally:nil];
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTypeViewMenuCell *cell = (MainTypeViewMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell unSelectedStatus];
}

#pragma mark- ProductListCollectionViewDelegate
- (void)productListCollectionViewWillBeginDragging:(UICollectionView *)collectionView {
    [self pushViewControllerToDetailViewController];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedItemIndex:(int)index {
    [self pushViewControllerToDetailViewController];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedBuyButton:(UIButton *)button index:(int)index {
    [self pushViewControllerToDetailViewController];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedLoveButton:(UIButton *)button index:(int)index {
    [self pushViewControllerToDetailViewController];
}

- (void)productListCollectionView:(ProductListCollectionView *)collectionView selectedUnloveButton:(UIButton *)button index:(int)index {
    [self pushViewControllerToDetailViewController];
}

@end
