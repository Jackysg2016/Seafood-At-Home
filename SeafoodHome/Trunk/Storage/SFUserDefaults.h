//
//  SFUserDefaults.h
//  SeafoodHome
//
//  Created by btw on 14/12/20.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductListCollectionView.h"

static NSString * const kISInit = @"ISInit";

static NSString * const kUserInfoKey = @"UserInfo";
static NSString * const kUserInfoKeyLogined = @"logined";
static NSString * const kUserInfoKeyUserID = @"userid";
static NSString * const kUserInfoKeyPhoneNumber = @"phone";
static NSString * const kUserInfoKeyRealName = @"realname";
static NSString * const kUserInfoKeyAddress = @"address";
static NSString * const kUserInfoKeyEmail = @"email";

static NSString * const kProductListCollectionViewStyle = @"ProductListCollectionViewStyle";
static NSString * const kChangeProductListStyleNotification = @"ChangeProductListStyleNotification";

static NSString * const kShoppingCarAmountKey = @"ShoppingCarAmount";
static NSString * const kChangeShoppingCarAmountNotification = @"ChangeShoppingCarAmountNotification";

@protocol SFUserDefaultsDelegate <NSObject>
@optional
/** 接收到修改产品列表风格的通知 */
- (void)receiveChangeProductListStyleNotification:(NSNotification *)notification;

/** 接收到修改购物车产品数量的通知 */
- (void)receiveChangeShoppingCarAmountNotification:(NSNotification *)notification;

@end

/**
 *  用来管理用户设置的类
 */
@interface SFUserDefaults : NSObject

/**
 *  创建SFUserDefaults的单例
 *
 *  @return SFUserDefaults的单例
 */
+ (SFUserDefaults *)sharedUserDefaults;

/**
 *  初始化用户数据(UserDefaults)
 */
- (void)initializationUserData;

/**
 *  是否已经初始化了用户的设置
 *
 *  @return 返回YES证明应用已经启动过，返回NO则应用已经启动过。
 */
- (BOOL)isInit;

/**
 *  设置产品列表的风格
 *
 *  @param style 风格类型
 */
- (void)setProductListCollectionViewStyle:(ProductListCollectionViewStyle)style;

/**
 *  获取产品列表的风格
 *
 *  @return 产品列表的风格
 */
- (ProductListCollectionViewStyle)productListCollectionViewStyle;

/**
 *  接收到产品列表的风格改变
 *
 *  @param observer 监听者
 */
- (void)receiveChangeProductListStyleNotificationWithObserver:(id<SFUserDefaultsDelegate>)observer;

/**
 *  使用通知中心后，需要移除所有的通知中心事件。
 *  此方法在observer的dealloc方法里面执行
 *
 *  @param observer 监听者
 */
- (void)removeObserver:(id)observer;

/** 设置用户信息 */
- (void)setUserInfoWithDictionary:(NSDictionary *)dictionary;

/** 获取用户信息 */
- (NSDictionary *)requestUserInfo;

/** 获取用户ID */
- (NSInteger)requestUserID;

/** 获取用户名 */
- (NSString *)requestUserName;

/** 退出登录 */
- (void)outLogin;

/** 是否已经登陆 */
- (BOOL)isLogined;

/****************************** 购物车 ******************************/
/** 获取购物车商品数量 */
- (int)requestShoppingCarCount;

/** 购物车数量＋1，返回之后的商品总数 */
- (int)shoppingCarCountAscending;

/** 添加N件商品到购物车，返回之后的商品总数 */
- (int)addShoppingCarCountWithAmount:(int)amount;

/** 从购物车里减去N件商品，返回之后的商品总数 */
- (int)subtractingShoppingCarCountWithAmount:(int)amount;

/** 重置购物车数量为0 */
- (int)shoppingCarCountReset;

/** 设置购物车数量为... */
- (BOOL)setShoppingCarCountTo:(int)amount;

/** 接收到更改购物车数量的事件 */
- (void)receiveChangeShoppingCarAmountNotificationWithObserver:(id<SFUserDefaultsDelegate>)observer;

// 获取远程的购物车数量
- (void)requestNetworkingShoppingCarCount;

@end
