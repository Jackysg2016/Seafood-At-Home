//
//  LeftViewPositionButtonView.h
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewPositionButtonView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

+ (instancetype)leftViewPositionButtonViewWithFrame:(CGRect)frame iconImageSize:(CGSize)iconImageSize iconImageNamed:(NSString *)imageNamed highlightedImageNamed:(NSString *)highlightedImageNamed;


@end
