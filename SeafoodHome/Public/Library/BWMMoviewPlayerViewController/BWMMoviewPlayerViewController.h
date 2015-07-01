//
//  BWMMoviewPlayerViewController.h
//  9SKG
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 9SKG. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 一个重写了UIViewController的只支持横屏播放的类 */
@interface BWMMoviewPlayerViewController : UIViewController

@property (strong, nonatomic) NSURL *contentURL;

- (instancetype)initWithContentURL:(NSURL *)contentURL;

@end
