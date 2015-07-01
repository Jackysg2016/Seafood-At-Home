//
//  ProductListCollectionViewHeader.m
//  SeafoodHome
//
//  Created by btw on 15/1/7.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ProductListCollectionViewHeader.h"
#import "Masonry.h"

@interface ProductListCollectionViewHeader()
{
    MainViewTypeTableHeaderView *_headerView;
}
@end

@implementation ProductListCollectionViewHeader

- (void)awakeFromNib {
    // Initialization code
    
    _headerView = [MainViewTypeTableHeaderView mainViewTypeTableHeaderViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, MainViewTypeTableHeaderView.height) delegate:_delegate];
    [_headerView hideButtons];
    [self addSubview:_headerView];
}

- (void)setDelegate:(id<MainViewTypeTableHeaderViewDelegate>)delegate
{
    _delegate = delegate;
    _headerView.delegate = _delegate;
}

- (void)showButton
{
    [_headerView showButtons];
}

- (void)hideButton
{
    [_headerView hideButtons];
}

@end
