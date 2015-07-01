//
//  TryViewFactory.h
//  SeafoodHome
//
//  Created by btw on 15/3/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TryView;
@protocol TryView;
typedef void(^TryViewBlock)(TryView *tryView);

@protocol TryViewFactory <NSObject>

- (TryView <TryView> *)tryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack;

@end

@interface TryViewFactory : NSObject

- (TryView <TryView> *)createTryViewWithTargetView:(UIView *)targetView clickedCallBack:(TryViewBlock)clickedCallBack;

@end
