//
//  SFUserDefaults.m
//  SeafoodHome
//
//  Created by btw on 14/12/20.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "SFUserDefaults.h"
#import "WTRequestCenter.h"

static SFUserDefaults *_userDefaultsSingleton;

@interface SFUserDefaults() {
    NSUserDefaults *_userDefaults;
    NSNotificationCenter *_notificationCenter;
}

@end

@implementation SFUserDefaults

- (instancetype)init {
    if (self = [super init]) {
        _userDefaults = [NSUserDefaults standardUserDefaults];
        _notificationCenter = [NSNotificationCenter defaultCenter];
    }
    return self;
}

+ (SFUserDefaults *)sharedUserDefaults {
    if (_userDefaultsSingleton == nil) {
        _userDefaultsSingleton = [[SFUserDefaults alloc] init];
    }
    
    return _userDefaultsSingleton;
}

- (BOOL)isInit {
    if ([_userDefaults objectForKey:kISInit] && [_userDefaults boolForKey:kISInit]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)initializationUserData {
    [_userDefaults setObject:@(YES) forKey:kISInit];
    // 初始化列表风格
    [self setProductListCollectionViewStyle:ProductListCollectionViewStyleGrid];
    // 初始化用户信息
    [_userDefaults setObject:[self originallyUserInfoDictionary] forKey:kUserInfoKey];
    // 初始化购物车数据
    [_userDefaults setObject:@0 forKey:kShoppingCarAmountKey];
    [_userDefaults synchronize];
}

- (NSDictionary *)originallyUserInfoDictionary {
    return @{
             kUserInfoKeyLogined : @(NO),
             kUserInfoKeyUserID : @0,
             kUserInfoKeyPhoneNumber : @"",
             kUserInfoKeyRealName : @"",
             kUserInfoKeyAddress : @"",
             kUserInfoKeyEmail : @""
             };
}

- (void)setProductListCollectionViewStyle:(ProductListCollectionViewStyle)style {
    [_notificationCenter postNotificationName:kChangeProductListStyleNotification object:[NSNumber numberWithInteger:style]];
    
    [_userDefaults setObject:[NSNumber numberWithInteger:style] forKey:kProductListCollectionViewStyle];
    [_userDefaults synchronize];
}

- (void)receiveChangeProductListStyleNotificationWithObserver:(id<SFUserDefaultsDelegate>)observer {
    [_notificationCenter addObserver:observer selector:@selector(receiveChangeProductListStyleNotification:) name:kChangeProductListStyleNotification object:nil];
}

- (ProductListCollectionViewStyle)productListCollectionViewStyle {
    return [[_userDefaults objectForKey:kProductListCollectionViewStyle] integerValue];
}

- (void)removeObserver:(id)observer {
    [_notificationCenter removeObserver:observer];
}

- (void)setUserInfoWithDictionary:(NSDictionary *)dictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [dict setObject:[NSNumber numberWithBool:YES] forKey:kUserInfoKeyLogined];
    [_userDefaults setObject:dict forKey:kUserInfoKey];
    [_userDefaults synchronize];
}

- (NSDictionary *)requestUserInfo {
    NSLog(@"%@", [_userDefaults dictionaryForKey:kUserInfoKey]);
    return [_userDefaults objectForKey:kUserInfoKey];
}

- (void)outLogin {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self requestUserInfo]];
    [dict setObject:[NSNumber numberWithBool:NO] forKey:kUserInfoKeyLogined];
    [_userDefaults setObject:dict forKey:kUserInfoKey];
    [_userDefaults synchronize];
}

- (NSString *)requestUserName {
    return [[self requestUserInfo] objectForKey:kUserInfoKeyPhoneNumber];
}

- (NSInteger)requestUserID {
    return [[[self requestUserInfo] objectForKey:kUserInfoKeyUserID] integerValue];
}

- (BOOL)isLogined {
    return [[[self requestUserInfo] objectForKey:kUserInfoKeyLogined] boolValue];
}

- (int)requestShoppingCarCount {
    return (int)[[_userDefaults objectForKey:kShoppingCarAmountKey] intValue];
}

- (int)shoppingCarCountAscending {
    return [self addShoppingCarCountWithAmount:1];
}

- (int)addShoppingCarCountWithAmount:(int)amount {
    NSInteger sum = [_userDefaults integerForKey:kShoppingCarAmountKey];
    sum += amount;
    [_userDefaults setObject:@(sum) forKey:kShoppingCarAmountKey];
    if([_userDefaults synchronize]) {
        [_notificationCenter postNotificationName:kChangeShoppingCarAmountNotification object:@(sum)];
    }
    return (int)sum;
}

- (int)subtractingShoppingCarCountWithAmount:(int)amount {
    NSInteger sum = [_userDefaults integerForKey:kShoppingCarAmountKey];
    sum -= amount;
    if (sum < 0) sum = 0;
    [_userDefaults setObject:@(sum) forKey:kShoppingCarAmountKey];
    if([_userDefaults synchronize]) {
        [_notificationCenter postNotificationName:kChangeShoppingCarAmountNotification object:@(sum)];
    }
    return (int)sum;
}


- (int)shoppingCarCountReset {
    [_userDefaults setObject:@0 forKey:kShoppingCarAmountKey];
    if ([_userDefaults synchronize]) {
        [_notificationCenter postNotificationName:kChangeShoppingCarAmountNotification object:@0];
    }
    return 0;
}

- (BOOL)setShoppingCarCountTo:(int)amount {
    [_userDefaults setObject:@(amount) forKey:kShoppingCarAmountKey];
    if ([_userDefaults synchronize]) {
        [_notificationCenter postNotificationName:kChangeShoppingCarAmountNotification object:@(amount)];
        return YES;
    } else {
        return NO;
    }
}

- (void)receiveChangeShoppingCarAmountNotificationWithObserver:(id<SFUserDefaultsDelegate>)observer {
    [_notificationCenter addObserver:observer selector:@selector(receiveChangeShoppingCarAmountNotification:) name:kChangeShoppingCarAmountNotification object:nil];
}

// 获取远程购物车数量
- (void)requestNetworkingShoppingCarCount {
    if ([[SFUserDefaults sharedUserDefaults] isLogined] == YES) {
        int userID = (int)[[SFUserDefaults sharedUserDefaults] requestUserID];
        NSString *api = [NSString stringWithFormat:@"http://seafood.beautyway.com.cn/json/webjson.ashx?aim=ShopCarList&index=1&size=0&userid=%d", userID];
        [WTRequestCenter getWithURL:api parameters:nil finished:^(NSURLResponse *response, NSData *data) {
            NSDictionary *dict = JSON_TO_DICT(data);
            if (dict[@"num"]) {
                int amount = [dict[@"num"] intValue];
                [[SFUserDefaults sharedUserDefaults] setShoppingCarCountTo:amount];
            }
        } failed:nil];
    } else {
        [[SFUserDefaults sharedUserDefaults] shoppingCarCountReset];
    }
}

@end