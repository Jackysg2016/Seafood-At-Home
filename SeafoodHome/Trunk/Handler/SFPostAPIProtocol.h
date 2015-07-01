//
//  SFPostAPIProtocol.h
//  SeafoodHome
//
//  Created by btw on 15/1/15.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#ifndef SeafoodHome_SFPostAPIProtocol_h
#define SeafoodHome_SFPostAPIProtocol_h

@protocol SFPostAPIProtocol <NSObject>

@required

- (NSDictionary *)postDictionary;
+ (NSString *)API;

@end

#endif
