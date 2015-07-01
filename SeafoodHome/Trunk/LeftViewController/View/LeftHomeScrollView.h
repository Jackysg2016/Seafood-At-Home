//
//  LeftHomeScrollView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/24.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagedFlowView.h"
#import "SMPageControl.h"

@class LeftHomeScrollView;

@protocol LeftHomeScrollViewDelegate <NSObject>

- (void)leftHomeScrollView:(LeftHomeScrollView *)scrollView itemClickedAtIndex:(int)index;

@end

/**
 *  左边侧滑首页的ScrollView
 */
@interface LeftHomeScrollView : UIView
<
    PagedFlowViewDataSource,
    PagedFlowViewDelegate
>

@property (strong, nonatomic) PagedFlowView *scrollView;
@property (strong, nonatomic) SMPageControl *pageControl;

/**
 *  包含图片的NSURL的数组, 由外部提供
 */
@property (strong, nonatomic) NSArray *dataArray;

@property (weak, nonatomic) id<LeftHomeScrollViewDelegate> delegate;

+ (instancetype)leftHomeScrollViewWithFrame:(CGRect)frame delegate:(id<LeftHomeScrollViewDelegate>)delegate;

@end
