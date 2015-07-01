//
//  MainViewTypeTableHeaderView.m
//  SeafoodHome
//
//  Created by btw on 14/12/17.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewTypeTableHeaderView.h"
#import "SFUserDefaults.h"

@interface MainViewTypeTableHeaderView ()
{
    NSMutableArray *_buttonArray;
}

@end

@implementation MainViewTypeTableHeaderView

+ (instancetype)mainViewTypeTableHeaderViewWithFrame:(CGRect)frame delegate:(id<MainViewTypeTableHeaderViewDelegate>)delegate
{
    MainViewTypeTableHeaderView *headerView = [[MainViewTypeTableHeaderView alloc] initWithFrame:frame];
    headerView.delegate = delegate;
    return headerView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _buttonArray = [[NSMutableArray alloc] init];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg"]];

    [self createImageView];
    
    [self createButton:CGRectMake(self.frame.size.width - 100, self.frame.size.height - 40 , 40, 40) imageNamed:@"product_list_grid_style" tag:0];
    
    [self createButton:CGRectMake(self.frame.size.width - 50, self.frame.size.height - 40 , 40, 40) imageNamed:@"product_list_list_style" tag:1];
    
    // 默认选中
    if ([[SFUserDefaults sharedUserDefaults] productListCollectionViewStyle] == ProductListCollectionViewStyleGrid)
    {
        ((UIButton *)_buttonArray[0]).selected = YES;
    }
    else
    {
        ((UIButton *)_buttonArray[1]).selected = YES;
    }
    
    
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-3, self.width, 3)];
    bottomLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"MainTypeMiddleShadow"]];
    [self addSubview:bottomLine];
}

#pragma mark- CreateImageView

- (void)createImageView
{
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ready_for_you"]];
    _imageView.frame = CGRectMake(0, 0, 213, 65);
    _imageView.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height/2.0);
    [self addSubview:_imageView];
}

#pragma mark- CreateButtons

- (void)createButton:(CGRect)frame imageNamed:(NSString *)imageNamed tag:(NSUInteger)tag
{
    CGRect listStyleButtonRect = frame;
    UIButton *listStyleButton = [[UIButton alloc] initWithFrame:listStyleButtonRect];
    [listStyleButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_off", imageNamed]] forState:UIControlStateNormal];
    [listStyleButton setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_on", imageNamed]] forState:UIControlStateSelected];
    [listStyleButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    listStyleButton.tag = tag;
    [self addSubview:listStyleButton];
    
    [_buttonArray addObject:listStyleButton];
}

- (void)buttonClicked:(UIButton *)button
{
    for (UIButton *btn in _buttonArray)
    {
        if (btn == button)
        {
            btn.selected = YES;
        }
        else
        {
            btn.selected = NO;
        }
    }
    
    [_delegate mainViewTypeTableHeaderView:self listStyleButtonClicked:button type:button.tag];
}

#pragma mark- hide and show buttons

- (void)hideButtons
{
    for (UIView *view in _buttonArray)
    {
        view.hidden = YES;
    }
}

- (void)showButtons
{
    for (UIView *view in _buttonArray)
    {
        view.hidden = NO;
    }
}

+ (CGFloat)height
{
    return AUTO_MATE_WIDTH(130.0f);
}

@end
