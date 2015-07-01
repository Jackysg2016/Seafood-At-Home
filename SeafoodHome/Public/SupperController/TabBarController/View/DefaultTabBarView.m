//
//  DefaultTabBarView.m
//  Seafood
//
//  Created by 伟明 毕 on 14/12/8.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DefaultTabBarView.h"
#import "DefaultTabBarItemView.h"

static NSString * const kBackgroundImageNamed      =   @"default_tabbar_bg";

static NSString * const kHomeTile                  =   @"首页";
static NSString * const kHomeItemImageNamed        =   @"tabbar_item_home";

static NSString * const kTypeTile                  =   @"分类";
static NSString * const kTypeItemImageNamed        =   @"tabbar_item_type";

static NSString * const kTipsTile                  =   @"贴士";
static NSString * const kTipsItemImageNamed        =   @"tabbar_item_tips";

static NSString * const kUserTile                  =   @"账户";
static NSString * const kUserItemImageNamed        =   @"tabbar_item_user";

static NSString * const kBrandItemNormalImageNamed =   @"tabbar_item_brand_normal";
static NSString * const kBrandItemLightImageNamed  =   @"tabbar_item_brand_light";

static float tabBarHeight = 63.0f;

@interface DefaultTabBarView()
{
    NSArray *_items;
}
@end

@implementation DefaultTabBarView

+ (instancetype)defaultTabBarViewWithFrame:(CGRect)frame delegate:(id<DefaultTabBarViewDelegate>)delegate
{
    CGRect newFrame = frame;
    newFrame.size.height = tabBarHeight;
    
    DefaultTabBarView *defaultTabBarView = [[DefaultTabBarView alloc] initWithFrame:newFrame];
    defaultTabBarView.delegate = delegate;
    
    return defaultTabBarView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createBackground];
        [self createItems];
    }
    return self;
}

// 创建背景
- (void)createBackground
{
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kBackgroundImageNamed]];
}

// 创建TabBar的Items
- (void)createItems
{
    // 距离上边的空隙
    static float topMargin = 12.5;
    
    // 首页的TabBarItem
    DefaultTabBarItemView *homeItemView = [DefaultTabBarItemView
                                           defaultTabBarItemViewWithFrame:CGRectMake(0, topMargin, AUTO_MATE_WIDTH(63), 51)
                                           imageNamed:kHomeItemImageNamed
                                           title:kHomeTile];
    [self addSubview:homeItemView];
    
    // 分类的TabBarItem
    DefaultTabBarItemView *typeItemView = [DefaultTabBarItemView
                                           defaultTabBarItemViewWithFrame:CGRectMake(AUTO_MATE_WIDTH(63), topMargin,
                                                                                            AUTO_MATE_WIDTH(63), 51)
                                           imageNamed:kTypeItemImageNamed
                                           title:kTypeTile];
    [self addSubview:typeItemView];
    
    // 贴士的TabBarItem
    DefaultTabBarItemView *tipsItemView = [DefaultTabBarItemView
                                           defaultTabBarItemViewWithFrame:CGRectMake(SCREEN_WIDTH - 2*AUTO_MATE_WIDTH(63), topMargin, AUTO_MATE_WIDTH(63), 51)
                                           imageNamed:kTipsItemImageNamed
                                           title:kTipsTile];
    [self addSubview:tipsItemView];
    
    // 账户的TabBarItem
    DefaultTabBarItemView *userItemView = [DefaultTabBarItemView defaultTabBarItemViewWithFrame:CGRectMake(SCREEN_WIDTH - AUTO_MATE_WIDTH(63), topMargin, AUTO_MATE_WIDTH(63), 51)
                                                                                     imageNamed:kUserItemImageNamed
                                                                                          title:kUserTile];
    [self addSubview:userItemView];
    
    // 品牌的TabBarItem，即中间那个，有特色的。
    UIImageView *brandItemView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kBrandItemNormalImageNamed] highlightedImage:[UIImage imageNamed:kBrandItemLightImageNamed]];
    brandItemView.userInteractionEnabled = YES;
    brandItemView.frame = CGRectMake((self.width - 73.5)/2.0, 6, 73.5, 58);
    [self addSubview:brandItemView];
    
    // 所有添加手势
    _items = @[homeItemView, typeItemView, brandItemView, tipsItemView, userItemView];
    for (int i = 0; i<_items.count; i++) {
        UIView *itemView = _items[i];
        itemView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemsClicked:)];
        [itemView addGestureRecognizer:tap];
    }
}

- (void)setSelectedItemAtIndex:(int)index {
    if (index != 2) {
        DefaultTabBarItemView *itemView = _items[index];
        [itemView setSelectedState];
    } else {
        UIImageView *brandItemView = (UIImageView *)_items[index];
        brandItemView.highlighted = YES;
    }
}

#pragma mark-

- (void)itemsClicked:(UIGestureRecognizer *)recognizer
{
//    // 设置未选状态
//    for (UIView *itemView in _items)
//    {
//        if ([itemView isKindOfClass:[DefaultTabBarItemView class]])
//        {
//            DefaultTabBarItemView *defaultTabBarItemView = (DefaultTabBarItemView *)itemView;
//            [defaultTabBarItemView setDeselectedState];
//        }
//        else  if ([itemView isKindOfClass:[UIImageView class]])
//        {
//            UIImageView *brandItemView = (UIImageView *)itemView;
//            brandItemView.highlighted = NO;
//        }
//    }
//    // end
//    
//    // 设置选中状态
//    if ([recognizer.view isKindOfClass:[DefaultTabBarItemView class]])
//    {
//        DefaultTabBarItemView *defaultTabBarItemView = (DefaultTabBarItemView *)recognizer.view;
//        [defaultTabBarItemView setSelectedState];
//    }
//    else if ([recognizer.view isKindOfClass:[UIImageView class]])
//    {
//        UIImageView *brandItemView = (UIImageView *)recognizer.view;
//        brandItemView.highlighted = YES;
//    }
//    // end
    
    // 回调代理方法，判断选择了哪个Item
    if (_delegate) [_delegate defaultTabBarView:self selectedIndex:(int)recognizer.view.tag];
}

@end
