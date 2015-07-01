//
//  TryHaiTaoScrollView.m
//  SeafoodHome
//
//  Created by btw on 14/12/10.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "TryHaiTaoScrollView.h"

static NSString *kTryImageNamed = @"home_top_try_icon";

@implementation TryHaiTaoScrollView

+ (instancetype)tryHaiTaoScrollViewWithFrame:(CGRect)frame imageURLArray:(NSArray *)imageURLArray delegate:(id<TryHaiTaoScrollViewDelegate>)delegate
{
    TryHaiTaoScrollView *tryHaiTaoScrollView = [[TryHaiTaoScrollView alloc] initWithFrame:frame];
    tryHaiTaoScrollView.imageURLArray = imageURLArray;
    tryHaiTaoScrollView.delegate = delegate;
    return tryHaiTaoScrollView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createScrollView];
        [self createTryImageView];
    }
    return self;
}

- (void)createScrollView
{
    _scrollView = [DetailImageBrowserScrollView detailImageBrowserScrollViewWithFrame:CGRectMake(0, 5, self.width - self.height - 3, self.height-10) imagesURLArray:_imageURLArray delegate:self];
    [_scrollView setItemSpacing:5.0 lineSpacing:5.0 sectionInset:UIEdgeInsetsMake(0, 5.0, 0, 5.0)];
    [self addSubview:_scrollView];
}

// right icon image
- (void)createTryImageView
{
    UIImageView *tryImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:kTryImageNamed]];
    float length = self.frame.size.height;
    tryImageView.frame = CGRectMake(self.width - length, 5, length - 8, length- 8);
    [self addSubview:tryImageView];
}

- (void)setImageURLArray:(NSArray *)imageURLArray
{
    _imageURLArray = imageURLArray;
    
    if (_scrollView)
    {
        [_scrollView updateWithImagesURLArray:imageURLArray delegate:self];
    }
}

#pragma mark- UICollectionViewDelegate

- (void)detailImageBrowserScrollView:(DetailImageBrowserScrollView *)detailImageBrowserScrollView itemClickedAtIndex:(int)clickedIndex
{
    [_delegate tryHaiTaoScrollView:self clickedIndex:clickedIndex];
}
@end
