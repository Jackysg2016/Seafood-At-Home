//
//  YoudaoTranslation.h
//  SeafoodHome
//
//  Created by btw on 15/2/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YoudaoTranslation;

typedef void (^YoudaoTranslationCallBack)(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err);

/**
 *  有道翻译
 */
@interface YoudaoTranslation : NSObject

/**
 *  需要翻译的文本
 */
@property (strong, nonatomic) NSString *prefixTranslationText;

@property (copy, nonatomic) YoudaoTranslationCallBack resultCallBack;

/**
 *  初始化有道翻译器
 *
 *  @param prefixTranslationText 需要翻译的文本
 *
 *  @return YoudaoTranslation Object
 */
- (YoudaoTranslation *)initWithPrefixTranslationText:(NSString *)prefixTranslationText;

/**
 *  设置成功与否的回调Block
 *
 *  @param resultCallBlack 回调结果块
 */
- (void)setResultCallBack:(void(^)(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err))resultCallBlack;

/**
 *  开始请求翻译
 */
- (void)start;

/**
 *  快速翻译
 *
 *  @param text            需要翻译的文本
 *  @param resultCallBlack 翻译结果回调的块
 *
 *  @return YoudaoTranslation Object
 */
+ (YoudaoTranslation *)translationText:(NSString *)text resultCallBlack:(void (^)(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err))resultCallBlack;

@end
