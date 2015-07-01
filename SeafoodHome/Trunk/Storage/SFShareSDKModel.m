//
//  MyShareSDKModel.m
//  SeafoodHome
//
//  Created by btw on 15/2/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "SFShareSDKModel.h"

@implementation SFShareSDKModel

+ (SFShareSDKModel *)modelWithTitle:(NSString *)title description:(NSString *)desc content:(NSString *)content defaultContent:(NSString *)defaultContent imageURLString:(NSString *)imageURLStr URLString:(NSString *)URLString sender:(UIView *)sender {
    SFShareSDKModel *model = [[SFShareSDKModel alloc] initWithTitle:title description:desc content:content defaultContent:defaultContent imageURLString:imageURLStr URLString:URLString sender:sender];
    return model;
}


- (instancetype)initWithTitle:(NSString *)title description:(NSString *)desc content:(NSString *)content defaultContent:(NSString *)defaultContent imageURLString:(NSString *)imageURLStr URLString:(NSString *)URLString sender:(UIView *)sender {
    if (self = [super init]) {
        self.title = title;
        self.desc = [self subStringTo200:desc];
        self.content = [self subStringTo200:content];
        self.defaultContent = [self subStringTo200:defaultContent];
        self.imageURLString = imageURLStr;
        self.URLString = URLString;
        self.sender = sender;
    }
    return self;
}

- (NSString *)subStringTo200:(NSString *)string {
    if ([string length] > 200) {
        string = [string substringToIndex:200];
    }
    return string;
}
@end
