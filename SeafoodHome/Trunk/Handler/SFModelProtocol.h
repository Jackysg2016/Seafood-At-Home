//
//  SFModelProtocol.h
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#ifndef SeafoodHome_SFModelProtocol_h
#define SeafoodHome_SFModelProtocol_h
@protocol SFModelProtocol <NSObject>

@required
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@optional
+ (NSString *)API;

@end
#endif