//
//  SFAPILoader.h
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "API.h"
#import "MJRefresh.h"

/**
 *  Remark类型
 */
typedef NS_ENUM(NSUInteger, RemarkSymbolType){
    /**
     *  单品
     */
    RemarkSymbolTypeProducts = 0,
    /**
     *  套餐
     */
    RemarkSymbolTypeCombo,
    /**
     *  特惠
     */
    RemarkSymbolTypePreferential,
    /**
     *  团购
     */
    RemarkSymbolTypeGroup,
    /**
     *  热门单品
     */
    RemarkSymbolTypeHotProducts,
    /**
     *  推荐
     */
    RemarkSymbolTypeRecommend
};

@protocol SFAPILoaderDelegate;

/**
 *  用来加载所有API的管理者
 */
@interface SFAPILoader : NSObject

/**
 *  SFAPILoader的Identity值，用来区分每个SFAPILoader
 */
@property (copy, nonatomic) NSString *identity;

/**
 *  SFAPILoader的delegate
 */
@property (weak, nonatomic) id<SFAPILoaderDelegate> delegate;

/**
 * SFAPILoader的URLString
 */
@property (copy, nonatomic) NSString *URLString;

/**
 *  Get或Post的参数
 */
@property (copy, nonatomic) NSDictionary *parameters;

/**
 *  是否显示HUD
 */
@property (assign, nonatomic) BOOL isShowHUD;

/**
 *  是否隐藏ViewController的view
 */
@property (assign, nonatomic) BOOL isHideViewOfViewController;

/**
 *  加载API的Get接口
 *
 *  @param URLString                  需要设置的URL的字符串
 *  @param parameters                 需要设置的参数
 *  @param identity                   需要设置的标识符
 *  @param isShowHUD                  是否需要显示HUD
 *  @param isHideViewOfViewController 是否需要在加载的时候隐藏ViewControllder的View，加载完后显示View
 *  @param delegate                   需要设置的代理
 *
 *  @return 返回一个SFAPILoader的对象
 */
+ (SFAPILoader *)loaderGetWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters identity:(NSString *)identity isShowHUD:(BOOL)isShowHUD isHideViewOfViewController:(BOOL)isHideViewOfViewController delegate:(id<SFAPILoaderDelegate>)delegate;

/**
 *  加载API的Post接口
 *
 *  @param URLString                  需要设置的URL的字符串
 *  @param parameters                 需要设置的参数
 *  @param identity                   需要设置的标识符
 *  @param isShowHUD                  是否需要显示HUD
 *  @param isHideViewOfViewController 是否需要在加载的时候隐藏ViewControllder的View，加载完后显示View
 *  @param delegate                   需要设置的代理
 *
 *  @return 返回一个SFAPILoader的对象
 */
+ (SFAPILoader *)loaderPostWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters identity:(NSString *)identity isShowHUD:(BOOL)isShowHUD isHideViewOfViewController:(BOOL)isHideViewOfViewController delegate:(id<SFAPILoaderDelegate>)delegate;

/** 加载网站API，带有HUD提示 */
+ (void)loadDataWithURLString:(NSString *)urlString delegate:(UIViewController *)delegate success:(void(^)(NSURLResponse *response, NSDictionary *dict))successBlock error:(void(^)(void))errorBlock finally:(void(^)(void))finallyBlock;

/** 加载网站API，不带HUD */
+ (void)loadDataWithURLString:(NSString *)urlString success:(void (^)(NSDictionary *responseDict))successBlock error:(void (^)(void))errorBlock alway:(void (^)(void))alwayBlock;

/** 加载网站API，自定义成功或错误消息 */
+ (void)loadDataWithURLString:(NSString *)urlString delegate:(id)delegate successMsg:(NSString *)successMsg success:(void (^)(NSDictionary *resultDict))successBlock error:(void (^)(void))errorBlock alway:(void (^)(void))alwayBlock;

/** 用于一进页面就加载的情况 */
+ (void)getWithURL1:(NSString *)url targetVC:(__weak UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed;

/** 用于加载更多 */
+ (void)getWithURL2:(NSString *)url targetVC:(UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed;

/** 用于刷新 */
+ (void)getWithURL3:(NSString *)url targetVC:(UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed;

/** 黑色左侧滑栏的用于一进页面就加载的情况 */
+ (void)b_getWithURL1:(NSString *)url targetVC:(__weak UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed;


/** remark类型字典 */
+ (NSDictionary *)remarkTypeDictionary;

@end



@protocol SFAPILoaderDelegate <NSObject>

@optional

/**
 *  已经加载成功的回调
 *
 *  @param loader   SFAPILoader
 *  @param result   返回的结果
 *  @param response NSURLResponse
 */
- (void)SFAPILoaderDidSuccess:(SFAPILoader *)loader result:(id)result response:(NSURLResponse *)response;

/**
 *  已经加载失败的回调
 *
 *  @param loader   SFAPILoader
 *  @param error    NSError
 *  @param response NSURLResponse
 */
- (void)SFAPILoaderDidError:(SFAPILoader *)loader error:(NSError *)error response:(NSURLResponse *)response;

/**
 *  无论失败与否，最终都会执行的回调
 *
 *  @param loader SFAPILoader
 */
- (void)SFAPILoaderDidFinally:(SFAPILoader *)loader;

@end

