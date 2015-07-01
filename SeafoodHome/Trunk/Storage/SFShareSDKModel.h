//
//  MyShareSDKModel.h
//  SeafoodHome
//
//  Created by btw on 15/2/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFShareSDKModel : NSObject

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *defaultContent;
@property (strong, nonatomic) NSString *imageURLString;
@property (strong, nonatomic) NSString *URLString;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *desc;
@property (strong, nonatomic) UIView *sender;

+ (SFShareSDKModel *)modelWithTitle:(NSString *)title description:(NSString *)desc content:(NSString *)content defaultContent:(NSString *)defaultContent imageURLString:(NSString *)imageURLStr URLString:(NSString *)URLString sender:(UIView *)sender;

- (instancetype)initWithTitle:(NSString *)title description:(NSString *)desc content:(NSString *)content defaultContent:(NSString *)defaultContent imageURLString:(NSString *)imageURLStr URLString:(NSString *)URLString sender:(UIView *)sender;

@end
