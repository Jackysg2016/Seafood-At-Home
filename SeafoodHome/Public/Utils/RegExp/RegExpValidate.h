//
//  RegExp.h
//  SeafoodHome
//
//  Created by btw on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  正则表达式验证类
 */
@interface RegExpValidate : NSObject

/** 邮箱 */
+ (BOOL)validateEmail:(NSString *)email;

/** 手机号码验证 */
+ (BOOL)validateMobile:(NSString *)mobile;

/** 车牌号验证 */
+ (BOOL)validateCarNo:(NSString *)carNo;

/** 车型 */
+ (BOOL)validateCarType:(NSString *)CarType;

/** 用户名 */
+ (BOOL)validateUserName:(NSString *)name;

/** 密码 */
+ (BOOL)validatePassword:(NSString *)passWord;

/** 昵称 */
+ (BOOL)validateNickname:(NSString *)nickname;

/** 身份证号 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;

/** 判断金钱 
 1.只能输入数字和小数点
 2.只能输入一个小数点
 3.小数点后后面只能输入两位数字 */
+ (BOOL)validateMoney: (NSString *)money;

@end
