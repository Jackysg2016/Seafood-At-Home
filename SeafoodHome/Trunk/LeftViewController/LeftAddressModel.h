//
//  LeftAddressModel.h
//  SeafoodHome
//
//  Created by btw on 15/1/27.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "SFModelProtocol.h"

/** 左视图控制器店铺地址的Model */
@interface LeftAddressModel : NSObject <SFModelProtocol>

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSURL *shopAddressImageURL;
@property (strong, nonatomic) NSString *shopName;
@property (strong, nonatomic) NSString *shopAddress;
/**
 *  电话号码的字符串
 */
@property (strong, nonatomic) NSMutableArray *telNumberArray;

@end
