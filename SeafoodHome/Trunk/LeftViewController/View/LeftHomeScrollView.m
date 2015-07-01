//
//  LeftHomeScrollView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/24.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftHomeScrollView.h"

static NSString * const kPageIndicatorImageNamed = @"left_page_control_off";
static NSString * const kCurrentPageIndicatorImageNamed = @"left_page_control_on";

@implementation LeftHomeScrollView

+ (instancetype)leftHomeScrollViewWithFrame:(CGRect)frame delegate:(id<LeftHomeScrollViewDelegate>)delegate
{
    LeftHomeScrollView *scrollView = [[LeftHomeScrollView alloc] initWithFrame:frame];
    scrollView.delegate = delegate;
    [scrollView createUI];
    return scrollView;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [_scrollView reloadData];
}

- (void)createUI
{
    // scrollView
    _scrollView = [[PagedFlowView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - 10)];
    _scrollView.delegate = self;
    _scrollView.dataSource = self;
    _scrollView.minimumPageAlpha = 0.8;
    _scrollView.minimumPageScale = 0.8;
    _scrollView.orientation = PagedFlowViewOrientationHorizontal;
    [self addSubview:_scrollView];
    
    // pageControl
    _pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0, self.height - 4, self.width, 4)];
    _pageControl.numberOfPages = _dataArray.count;
    _pageControl.indicatorMargin = 6.0f;
    _pageControl.indicatorDiameter = 4.0f;
    _pageControl.alignment = SMPageControlAlignmentCenter;
    [_pageControl setPageIndicatorImage:[UIImage imageNamed:kPageIndicatorImageNamed]];
    [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:kCurrentPageIndicatorImageNamed]];
    [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    _scrollView.pageControl = (UIPageControl *)_pageControl;
}

- (void)pageControlValueChanged:(SMPageControl *)pageControl
{
    // 滚动到相应页面
    [_scrollView scrollToPage:pageControl.currentPage];
}

#pragma mark- PagedFlowViewDelegate

//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView
{
    return _dataArray.count;
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index
{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView)
    {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 2;
        imageView.layer.masksToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    [imageView sd_setImageWithURL:_dataArray[index] placeholderImage:WAIT_LOADING_IMAGE];
    return imageView;
}

- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView
{
    if (IS_IPHONE6)
    {
        return CGSizeMake(220, flowView.height);
    }
    else if (IS_IPHONE4_5)
    {
        return CGSizeMake(190, flowView.height);
    }
    else if (IS_IPHONE6_PLUS)
    {
        return CGSizeMake(240, flowView.height);
    }
    
    return CGSizeMake(AUTO_MATE_WIDTH(190), flowView.height);
}

// 滚动到当前页触发此事件
- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index
{
    
}

// 点击的时候触发
- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index
{
    [_delegate leftHomeScrollView:self itemClickedAtIndex:(int)index];
}

@end
