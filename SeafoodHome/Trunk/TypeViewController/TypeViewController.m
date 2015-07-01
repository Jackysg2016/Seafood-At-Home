//
//  TypeViewController.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "TypeViewController.h"
#import "MainViewTypeTableHeaderView.h"
#import "MainTypeViewMenuCell.h"
#import "TypeListViewController.h"
#import "TypeProgressViewController.h"
#import "SFAPILoader.h"
#import "TypeViewModel.h"
#import "SFVCProtocol.h"

static NSString * const kCellIdentity = @"MainTypeViewMenuCell";

@interface TypeViewController()<SFVCProtocol> {
    MainViewTypeTableHeaderView *_headerView;
    UITableView *_leftTableView;
    UITableView *_rightTableView;
    NSInteger _leftSelectedRow;
    NSInteger _rightSelectedRow;
    
    NSArray *_dataArray;
    NSArray *_subDataArray;
    NSDictionary *_remarkTypeDict;
}
@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSearchBar];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeSlidingMenuButton];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    
    _leftSelectedRow = -1;
    _rightSelectedRow = -1;
    _remarkTypeDict = [SFAPILoader remarkTypeDictionary];
    
    [self createUI];
    
    [SFAPILoader getWithURL1:[TypeViewModel API] targetVC:self finished:^(NSURLResponse *response, NSDictionary *responseDict) {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in responseDict[@"result"]) {
            TypeViewModel *model = [[TypeViewModel alloc] initWithDictionary:dict];
            [tempArray addObject:model];
        }
        _dataArray = tempArray;
        
        [_leftTableView reloadData];
    } failed:nil];
}

- (void)createUI {
    _headerView = [[MainViewTypeTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [MainViewTypeTableHeaderView height])];
    [_headerView hideButtons];
    [self.view addSubview:_headerView];
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerView.height-2, self.view.width/2.0-4, self.view.height-_headerView.height-NavigationBar_HEIGHT-STATUSBAR_HEIGHT-49) style:UITableViewStylePlain];
    _leftTableView.backgroundColor = [UIColor clearColor];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.separatorInset = UIEdgeInsetsZero;
    _leftTableView.showsVerticalScrollIndicator = NO;
    [_leftTableView registerNib:NIB_NAMED([MainTypeViewMenuCell class]) forCellReuseIdentifier:kCellIdentity];
    [self.view addSubview:_leftTableView];
    
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.width/2.0+4, _headerView.height-2, self.view.width/2.0-4, self.view.height-_headerView.height-NavigationBar_HEIGHT-STATUSBAR_HEIGHT-49) style:UITableViewStylePlain];
    _rightTableView.backgroundColor = [UIColor clearColor];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.separatorInset = UIEdgeInsetsZero;
    _rightTableView.showsVerticalScrollIndicator = NO;
    [_rightTableView registerNib:NIB_NAMED([MainTypeViewMenuCell class]) forCellReuseIdentifier:kCellIdentity];
    [self.view addSubview:_rightTableView];
    
    UIView *yellowLine = [[UIView alloc] initWithFrame:CGRectMake(_leftTableView.width, _headerView.height-2, 8.0, 1000)];
    yellowLine.backgroundColor = MAIN_YELLOW_COLOR;
    [self.view addSubview:yellowLine];
}

#pragma mark- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _leftTableView) {
        return _dataArray.count;
    } else {
        return _subDataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _leftTableView) {
        MainTypeViewMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];

        TypeViewModel *model = _dataArray[indexPath.row];
        [cell updateCellWithTitle:model.superTypeName];

        if (_leftSelectedRow == indexPath.row) {
            [cell selectedStatus];
        } else {
            [cell unSelectedStatus];
        }
        return cell;
    } else {
        MainTypeViewMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
        
        SubTypeModel *model = _subDataArray[indexPath.row];
        [cell updateCellWithTitle:model.subTypeName];
        
        if (_rightSelectedRow == indexPath.row) {
            [cell selectedStatus];
        } else {
            [cell unSelectedStatus];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTypeViewMenuCell *cell = (MainTypeViewMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell selectedStatus];
    if (tableView == _leftTableView) {
        _leftSelectedRow = indexPath.row;
        _rightSelectedRow = -1;
        _subDataArray = [_dataArray[_leftSelectedRow] subTypesArray];
        [_rightTableView reloadData];
        // 如果没有子类了，就直接到达列表页
        if (_subDataArray.count == 0) {
            [self pushToTypeListViewControllerWithRemark];
        }
    } else {
        // 右边的TableView被点击，证明需要推到ProgressViewController
        _rightSelectedRow = indexPath.row;
        [self pushToTypeProgressViewController];
    }
}

// 推到目标分类列表视图控制器
- (void)pushToTypeListViewControllerWithRemark {
    TypeViewModel *model = _dataArray[_leftSelectedRow];
    RemarkSymbolType remark = model.remark;
    NSString *APIName = _remarkTypeDict[@(remark)];
    NSString *categoryID = [NSString stringWithFormat:@"%d", model.superTypeID];
    NSString *breadID = @"";
    if ([_subDataArray count] > 0) {
        SubTypeModel *model = _subDataArray[_rightSelectedRow];
        breadID = [NSString stringWithFormat:@"%d", model.subTypeID];
    }
    NSString *APIFormat = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=%@&categoryid=%@&breedid=%@&size=16&index=", APIName, categoryID, breadID];
    NSLog(@"%@", APIFormat);
    
    TypeListViewController *vc = [[TypeListViewController alloc] initWithAPIFormat:APIFormat remark:remark];
    [self.navigationController pushViewController:vc animated:YES];
}

// 推动分类和内容页中间的视图控制器
- (void)pushToTypeProgressViewController {
    SubTypeModel *subModel = _subDataArray[_rightSelectedRow];
    
    TypeProgressViewController *vc = [[TypeProgressViewController alloc] initWithSubTypeArray:_subDataArray selectedSubTypeModel:subModel];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    MainTypeViewMenuCell *cell = (MainTypeViewMenuCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell unSelectedStatus];
}

@end