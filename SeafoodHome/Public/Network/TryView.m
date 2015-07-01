//
//  TryView.m
//  SeafoodHome
//
//  Created by btw on 15/1/11.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TryView.h"
#import <objc/runtime.h>

#import "UserUnLoginTryView.h"

@interface TryView() <TryView>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *button;

@end

@implementation TryView

- (void)hideButton {
    self.button.hidden = YES;
}

- (void)setLightTextColor {
    self.titleLabel.textColor = [UIColor groupTableViewBackgroundColor];
}

- (instancetype)initWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack {
    
    Class currentCalss = [self class];
    self = [[[NSBundle mainBundle] loadNibNamed:@"TryView" owner:self options:nil] lastObject];
    object_setClass(self, currentCalss);
    
    self.targetView = targetView;
    self.clickedCallBack = clickedCallBack;
    
    self.tag = 404;
    self.frame = _targetView.bounds;
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:self.backgroundImageNamed]];
    
    self.imageView.image = [UIImage imageNamed:self.imageNamed];
    self.titleLabel.text = self.labelText;
    [self.button setTitle:self.buttonTitle forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [_targetView addSubview:self];

    return self;
}
- (void)buttonClicked:(UIButton *)button {
    if (_clickedCallBack) _clickedCallBack(self);
}

- (NSString *)imageNamed {
    return nil;
}
- (NSString *)labelText {
    return nil;
}
- (NSString *)buttonTitle {
    return nil;
}
- (NSString *)backgroundImageNamed {
    return nil;
}

@end
