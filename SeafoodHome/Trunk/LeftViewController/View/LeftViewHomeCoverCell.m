//
//  LeftViewHomeCoverCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewHomeCoverCell.h"

static NSString * const kCoverBackgoundImageNamed = @"left_view_home_cover_bg";

@implementation LeftViewHomeCoverCell

- (void)createUIWithImagesURLArray:(NSArray *)imagesURLArray delegate:(id<LeftViewHomeCoverCellDelegate>)delegate
{
    if (_coverView)
    {
        return;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kCoverBackgoundImageNamed]];
    
    _delegate = delegate;
    
    _coverView = [LeftHomeScrollView leftHomeScrollViewWithFrame:CGRectMake(0, 10, AUTO_MATE_WIDTH(265), 106) delegate:self];
    
    [self.contentView addSubview:_coverView];
}

- (void)setImagesURLArray:(NSArray *)imagesURLArray
{
    _imagesURLArray = imagesURLArray;
    if (_imagesURLArray)
    {
        [_coverView setDataArray:_imagesURLArray];
    }
}

#pragma mark- LeftHomeScrollViewDelegate

- (void)leftHomeScrollView:(LeftHomeScrollView *)scrollView itemClickedAtIndex:(int)index
{
    if (_delegate)
    {
        [_delegate leftViewHomeCoverCell:self clickedIndex:index];
    }
}

@end
