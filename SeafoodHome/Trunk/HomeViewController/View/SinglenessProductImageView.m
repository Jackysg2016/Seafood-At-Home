//
//  SinglenessProductImageView.m
//  SeafoodHome
//
//  Created by btw on 14/12/12.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "SinglenessProductImageView.h"

@implementation SinglenessProductImageView

+ (instancetype)singlenessProductImageViewWithFrame:(CGRect)frame imageURL:(NSURL *)imageURL
{
    SinglenessProductImageView *view = [[SinglenessProductImageView alloc] initWithFrame:frame];
    view.imageURL = imageURL;
    return view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initalizationUserInterface];
    }
    return self;
}

// 初始化界面
- (void)initalizationUserInterface
{
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.cornerRadius = 4.0f;
    _imageView.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.8].CGColor;
    _imageView.layer.borderWidth = 1.0f;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_imageView];
}

#pragma mark-

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:imageURL placeholderImage:WAIT_LOADING_IMAGE];
}

@end
