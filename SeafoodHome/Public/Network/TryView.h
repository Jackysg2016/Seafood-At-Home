//
//  TryView.h
//  SeafoodHome
//
//  Created by btw on 15/1/11.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TryView;

typedef void(^TryViewBlock)(TryView *tryView);

@protocol TryView <NSObject>

- (NSString *)imageNamed;
- (NSString *)labelText;
- (NSString *)buttonTitle;
- (NSString *)backgroundImageNamed;

@end

@interface TryView : UIView

@property (copy, nonatomic) TryViewBlock clickedCallBack;
@property (weak, nonatomic) UIView *targetView;

- (void)hideButton;
- (void)setLightTextColor;

- (instancetype)initWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack;

@end