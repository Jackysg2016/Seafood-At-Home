//
//  StarImageView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/20.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "StarImageView.h"

static NSString * const kBlankStarImageNamed = @"product_list_star_off";
static NSString * const kSolidStarImageNamed = @"product_list_star_on";

@implementation StarImageView

+ (instancetype)starImageViewWithFrame:(CGRect)frame rank:(int)rank
{
    StarImageView *starImageView = [[StarImageView alloc] initWithFrame:frame];
    [starImageView createStarImageViewWithImageNamed:kSolidStarImageNamed rank:rank];
    return starImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self createStarImageViewWithImageNamed:kBlankStarImageNamed rank:5];
    }
    return self;
}

- (void)awakeFromNib
{
    
}

// 创建星星
- (void)createStarImageViewWithImageNamed:(NSString *)imageNamed rank:(int)rank
{
    for (int i = 0; i<rank; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNamed]];
        imageView.frame = CGRectMake((8+2)*i, 0, 8, 8);
        [self addSubview:imageView];
    }
}

- (void)setRank:(int)rank
{
    _rank = rank;
    
    for (UIView *view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self createStarImageViewWithImageNamed:kBlankStarImageNamed rank:5];
    [self createStarImageViewWithImageNamed:kSolidStarImageNamed rank:rank];
}

@end
