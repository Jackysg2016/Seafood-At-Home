//
//  YoudaoTranslation.m
//  SeafoodHome
//
//  Created by btw on 15/2/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "YoudaoTranslation.h"
#import "WTRequestCenter.h"

// 填上申请的有道词典请求API
static NSString * APIFormat = @"http://fanyi.youdao.com/openapi.do?keyfrom=Seafood-123&key=342260366&type=data&doctype=json&version=1.1&q=%@";

@implementation YoudaoTranslation

- (YoudaoTranslation *)initWithPrefixTranslationText:(NSString *)prefixTranslationText {
    if (self = [super init]) {
        _prefixTranslationText = prefixTranslationText;
    }
    return self;
}

+ (YoudaoTranslation *)translationText:(NSString *)text resultCallBlack:(void (^)(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err))resultCallBlack {
    YoudaoTranslation *translation = [[YoudaoTranslation alloc] initWithPrefixTranslationText:text];
    [translation setResultCallBack:^(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err) {
        if (err == nil) {
            NSLog(@"%@的翻译结果为%@", prefixText, resultText);
            resultCallBlack(obj, prefixText, resultText, nil);
        }
        else {
            NSLog(@"翻译失败！");
            resultCallBlack(obj, prefixText, nil, err);
        }
    }];
    [translation start];
    return translation;
}

- (void)start {
    NSString *requestAPI = [NSString stringWithFormat:APIFormat, _prefixTranslationText];
    [WTRequestCenter getWithURL:requestAPI parameters:nil option:WTRequestCenterCachePolicyCacheElseWeb finished:^(NSURLResponse *response, NSData *data) {
        if (data.length > 0) {
            NSError *error = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                if (_resultCallBack) _resultCallBack(self, _prefixTranslationText, nil, error);
                return;
            }
            
            if([[dict objectForKey:@"errorCode"] intValue] == 0 &&
               [[dict objectForKey:@"translation"] isKindOfClass:[NSArray class]] &&
               [[dict objectForKey:@"translation"] count] > 0) {
                NSString *resultString = [[dict objectForKey:@"translation"] firstObject];
                if(_resultCallBack) _resultCallBack(self, _prefixTranslationText, resultString, nil);
            } else {
                if (_resultCallBack) _resultCallBack(self, _prefixTranslationText, nil, nil);
                return;
            }
        }
    } failed:^(NSURLResponse *response, NSError *error) {
        if (_resultCallBack) _resultCallBack(self, _prefixTranslationText, nil, error);
    }];
}

@end
