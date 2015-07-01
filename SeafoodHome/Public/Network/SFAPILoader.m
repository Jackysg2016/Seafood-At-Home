//
//  SFAPILoader.m
//  SeafoodHome
//
//  Created by btw on 15/1/9.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "SFAPILoader.h"
#import "WTRequestCenter.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "FXBlurView.h"
#import "TryView.h"
#import "ConnectErrorTryViewFactory.h"
#import "DataEmptyTryViewFactory.h"
#import "UserUnLoginTryViewFactory.h"
#import "ConnectErrorBackTryViewFactory.h"
#import "DataEmptyBackTryViewFactory.h"

static NSString * const kHUDLoadingMsg = @"正在加载";
static NSString * const kHUDNotMoreMsg = @"没有更多的数据了";
static NSString * const kHUDSuccessMsg = @"加载成功";
static NSString * const kHUDErrorMsg = @"加载失败";
static NSString * const kHUDNetworkErrorMsg = @"加载失败，请检查网络状态。";
static NSString * const kHUDNetworkTimeOutMsg = @"加载超时，请重试！";

typedef NS_ENUM(NSInteger, SFAPILoaderDataReturnValue)
{
    SFAPILoaderDataReturnValueSuccess = 0,
    SFAPILoaderDataReturnValueError
};

@implementation SFAPILoader

+ (SFAPILoader *)loaderGetWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters identity:(NSString *)identity isShowHUD:(BOOL)isShowHUD isHideViewOfViewController:(BOOL)isHideViewOfViewController delegate:(id<SFAPILoaderDelegate>)delegate
{
    SFAPILoader *loader = [[SFAPILoader alloc] init];
    loader.URLString = URLString;
    loader.parameters = parameters;
    loader.delegate = delegate;
    loader.identity = identity;
    loader.isShowHUD = isShowHUD;
    loader.isHideViewOfViewController = isHideViewOfViewController;
    [loader doGetRequest];
    return loader;
}

+ (SFAPILoader *)loaderPostWithURLString:(NSString *)URLString parameters:(NSDictionary *)parameters identity:(NSString *)identity isShowHUD:(BOOL)isShowHUD isHideViewOfViewController:(BOOL)isHideViewOfViewController delegate:(id<SFAPILoaderDelegate>)delegate
{
    SFAPILoader *loader = [[SFAPILoader alloc] init];
    loader.URLString = URLString;
    loader.parameters = parameters;
    loader.delegate = delegate;
    loader.identity = identity;
    loader.isShowHUD = isShowHUD;
    loader.isHideViewOfViewController = isHideViewOfViewController;
    [loader doPostRequest];
    return loader;
}

// 开始Get请求
- (void)doGetRequest
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self HUDShowWithStatus:kHUDLoadingMsg];
    [self hideAllView];
    
    [WTRequestCenter getWithURL:_URLString parameters:_parameters finished:^(NSURLResponse *response, NSData *data) {
        [self loadFinished:response data:data];
        [self showAllView];
    } failed:^(NSURLResponse *response, NSError *error)
    {
        [self loadError:response error:error];
    }]; // end WTRequestCenter
        
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 开始Post请求
- (void)doPostRequest
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self HUDShowWithStatus:kHUDLoadingMsg];
    [self hideAllView];
    
    [WTRequestCenter postWithURL:_URLString parameters:_parameters finished:^(NSURLResponse *response, NSData *data) {
        [self loadFinished:response data:data];
        [self showAllView];
    } failed:^(NSURLResponse *response, NSError *error) {
        [self loadError:response error:error];
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

// 加载完毕处理数据
- (void)loadFinished:(NSURLResponse *)response data:(NSData *)data
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    if (SFAPILoaderDataReturnValueSuccess == [rootDict[@"ret"] integerValue])
    {
        id result = rootDict[@"result"]; // 结果集
        
        if ([result isKindOfClass:[NSDictionary class]] || [result isKindOfClass:[NSArray class]])
        {
            // result的长度为0，证明result没有返回值
            if ([result count] == 0)
            {
                // 如果msg有信息就输出msg的信息
                if ([rootDict[@"msg"] length] != 0)
                {
                    [self HUDShowSuccessWithStatus:rootDict[@"msg"]];
                }
                else
                {
                    [self HUDShowSuccessWithStatus:kHUDNotMoreMsg];
                }
            }
            else
            {
                // 长度不为0，就代表加载成功而有返回值
                if (_delegate && [_delegate respondsToSelector:@selector(SFAPILoaderDidSuccess:result:response:)])
                {
                    [_delegate SFAPILoaderDidSuccess:self result:result response:response];
                }
                
                [self HUDShowSuccessWithStatus:kHUDSuccessMsg];
            } // end if ([result count] == 0)
        } // end is kind
    }
    else if (SFAPILoaderDataReturnValueError == [rootDict[@"ret"] integerValue])
    {
        // 异常情况
        NSString *msg = rootDict[@"msg"];
        if ([msg length] != 0)
        {
            [self HUDShowErrorWithStatus:msg];
        }
        else
        {
            [self HUDShowErrorWithStatus:kHUDNotMoreMsg];
        }
    } // End ReturnValue
    
    if (_delegate && [_delegate respondsToSelector:@selector(SFAPILoaderDidFinally:)])
    {
        [_delegate SFAPILoaderDidFinally:self];
    }
}


// 加载失败
- (void)loadError:(NSURLResponse *)response error:(NSError *)error
{
    NSString *msg = nil;
    
    switch (error.code)
    {
        case NSURLErrorTimedOut:
        msg = kHUDNetworkTimeOutMsg;
        break;
        
        default:
        msg = kHUDErrorMsg;
        break;
    }
    
    [self HUDShowErrorWithStatus:msg];
    
    if (_delegate && [_delegate respondsToSelector:@selector(SFAPILoaderDidError:error:response:)])
    {
        [_delegate SFAPILoaderDidError:self error:error response:response];
        [_delegate SFAPILoaderDidFinally:self];
    }

}

#pragma mark- HUD

- (void)HUDShowWithStatus:(NSString *)status
{
    if (_isShowHUD)
    {
        [SVProgressHUD showWithStatus:status];
    }
}

- (void)HUDShowSuccessWithStatus:(NSString *)status
{
    if (_isShowHUD)
    {
        [SVProgressHUD showSuccessWithStatus:status];
    }
}

- (void)HUDShowErrorWithStatus:(NSString *)status
{
    if (_isShowHUD)
    {
        [SVProgressHUD showErrorWithStatus:status];
    }
}

- (void)HUDDismiss
{
    if (_isShowHUD)
    {
        [SVProgressHUD dismiss];
    }
}

#pragma mark-

// 对delegate（UIViewController）进行隐藏视图
- (void)hideAllView
{
    if (_isHideViewOfViewController && [_delegate isKindOfClass:[UIViewController class]])
    {
        UIViewController *vc = (UIViewController *)_delegate;
        for (UIView *view in vc.view.subviews)
        {
            view.hidden = YES;
        }
    }
}

- (void)showAllView
{
    if (_isHideViewOfViewController && [_delegate isKindOfClass:[UIViewController class]])
    {
        UIViewController *vc = (UIViewController *)_delegate;
        for (UIView *view in vc.view.subviews)
        {
            view.hidden = NO;
        }
    }
}

#pragma mark-
+ (void)loadDataWithURLString:(NSString *)urlString delegate:(UIViewController *)delegate success:(void(^)(NSURLResponse *response, NSDictionary *dict))successBlock error:(void(^)(void))errorBlock finally:(void(^)(void))finallyBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 加载数据
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:delegate.view animated:YES];
    hud.animationType = MBProgressHUDAnimationZoomIn;
    hud.labelText = @"正在加载";
    [hud setYOffset:-30];
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    WTRequestCenterCachePolicy policy;
    if(appDelegate.hasNetWorking) {
        policy = WTRequestCenterCachePolicyNormal;
    } else {
        policy = WTRequestCenterCachePolicyOnlyCache;
    }
    
    [WTRequestCenter getWithURL:urlString parameters:nil option:policy finished:^(NSURLResponse *response, NSData *data){
        
        if (data.length==0 && (!appDelegate.hasNetWorking)) {
            hud.labelText = @"加载失败: 没有找到缓存";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:0.5];
            return;
        }
        if ([JSON_TO_DICT(data) objectForKey:@"result"] && [[JSON_TO_DICT(data) objectForKey:@"result"] count]==0)
        {
            hud.labelText = @"没有更多数据了";
            hud.mode = MBProgressHUDModeText;
            [hud hide:YES afterDelay:0.5];
            if(errorBlock) errorBlock();
        } else {
            // 加载成功
            if (successBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                    successBlock(response, dict);
                });
            }
            hud.labelText = @"加载成功";
            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
            hud.mode = MBProgressHUDModeCustomView;
            [hud hide:YES afterDelay:0.5];
        }
        
        if (finallyBlock) finallyBlock();
        
    } failed:^(NSURLResponse *response, NSError *error) {
        
        hud.labelText = @"加载失败";
        hud.mode = MBProgressHUDModeText;
        [hud hide:YES afterDelay:0.5];
        if (errorBlock) errorBlock();
        
        if (finallyBlock) finallyBlock();
        
    }];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (void)loadDataWithURLString:(NSString *)urlString success:(void (^)(NSDictionary *responseDict))successBlock error:(void (^)(void))errorBlock alway:(void (^)(void))alwayBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    WTRequestCenterCachePolicy policy;
    if(appDelegate.hasNetWorking) {
        policy = WTRequestCenterCachePolicyNormal;
    } else {
        policy = WTRequestCenterCachePolicyOnlyCache;
    }
    
    [WTRequestCenter getWithURL:urlString parameters:nil option:policy finished:^(NSURLResponse *respnse, NSData *data) {
        
        if (data.length>0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if(successBlock) successBlock(dict);
        } else {
            if(errorBlock) errorBlock();
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(alwayBlock) alwayBlock();
    } failed:^(NSURLResponse *response, NSError *error) {
        
        if(errorBlock) errorBlock();
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(alwayBlock) alwayBlock();
    }];
}

+ (void)loadDataWithURLString:(NSString *)urlString delegate:(id)delegate successMsg:(NSString *)successMsg success:(void (^)(NSDictionary *resultDict))successBlock error:(void (^)(void))errorBlock alway:(void (^)(void))alwayBlock
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[delegate view] animated:YES];
    hud.labelText = @"请稍后...";
    
    WTRequestCenterCachePolicy policy;
    if(appDelegate.hasNetWorking) {
        policy = WTRequestCenterCachePolicyNormal;
    } else {
        policy = WTRequestCenterCachePolicyOnlyCache;
    }
    
    [WTRequestCenter getWithURL:urlString parameters:nil option:policy finished:^(NSURLResponse *respnse, NSData *data) {
        
        hud.mode = MBProgressHUDModeText;
        
        if (data.length>0) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([[dict objectForKey:@"ret"] integerValue] == 0)
            {
                if(successBlock) successBlock(dict);
                
                hud.labelText = successMsg;
            }
            else
            {
                if (dict[@"msg"])
                {
                    hud.labelText = dict[@"msg"];
                }
                else
                {
                    hud.labelText = @"加载失败";
                }
            }
        }
        else
        {
            hud.labelText = @"加载失败";
            if(errorBlock) errorBlock();
        }
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(alwayBlock) alwayBlock();
        
        [hud hide:YES afterDelay:1.0];
    } failed:^(NSURLResponse *response, NSError *error) {
        
        if(errorBlock) errorBlock();
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if(alwayBlock) alwayBlock();
        hud.labelText = @"加载失败";
        [hud hide:YES afterDelay:1.0];
    }];
}

+ (void)dataEmptyTryViewWithType:(NSString *)type VC:(UIViewController *)vc {
    TryViewFactory <TryViewFactory> *dataEmptyTryViewFactory = nil;
    
    if ([type isEqualToString:@"black"]) {
        dataEmptyTryViewFactory = [[DataEmptyBackTryViewFactory alloc] init];
    } else {
        dataEmptyTryViewFactory = [[DataEmptyTryViewFactory alloc] init];
    }
    
    TryView <TryView> *tryView = [dataEmptyTryViewFactory createTryViewWithTargetView:vc.view clickedCallBack:^(TryView *tryView) {
        [vc.navigationController popViewControllerAnimated:YES];
    }];
    
    if (!(vc.navigationController && vc.navigationController.viewControllers.count > 1)) {
        [tryView hideButton];
    }
}

// 用于一进页面就加载的情况
+ (void)getWithURL1:(NSString *)url targetVC:(__weak UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(&*targetVC)VC = targetVC;
    UIView *bg = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg"]];
    [VC.view addSubview:bg];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:VC.view animated:YES];
    hud.labelText = @"正在加载中";
    [hud setYOffset:-30];
    [WTRequestCenter getWithURL:url parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dict = JSON_TO_DICT(data);
        if ([dict[@"result"] isKindOfClass:[NSString class]]) {
            [[self class] dataEmptyTryViewWithType:@"yellow" VC:targetVC];
            [bg removeFromSuperview];
        } else {
            if ([dict[@"result"] count] == 0) {
                [[self class] dataEmptyTryViewWithType:@"yellow" VC:targetVC];
                [bg removeFromSuperview];
            } else {
                if (finished) finished(response, dict);
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                hud.labelText = @"加载成功";
                hud.mode = MBProgressHUDModeCustomView;
                [UIView animateKeyframesWithDuration:0.3 delay:0.3 options:0 animations:^{
                    bg.alpha = 0;
                } completion:^(BOOL finished) {
                    [bg removeFromSuperview];
                }];
            }
        }
        [hud hide:YES afterDelay:0.5];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failed:^(NSURLResponse *response, NSError *error) {
        if (failed) failed(response, error);
        TryViewFactory <TryViewFactory> *connectErrorTryViewFactory = [[ConnectErrorTryViewFactory alloc] init];
        [connectErrorTryViewFactory createTryViewWithTargetView:targetVC.view clickedCallBack:^(TryView *tryView) {
            [[self class] getWithURL1:url targetVC:VC finished:finished failed:failed];
            [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:0 animations:^{
                bg.alpha = 0;
            } completion:^(BOOL finished) {
                [bg removeFromSuperview];
            }];
            [tryView removeFromSuperview];
        }];
        [hud hide:YES afterDelay:0.5];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

// 用于加载更多
+ (void)getWithURL2:(NSString *)url targetVC:(UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [WTRequestCenter getWithURL:url parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dict = JSON_TO_DICT(data);
        if([dict[@"result"] count] == 0) {
            if (failed) failed(response, nil);
            [SVProgressHUD showErrorWithStatus:@"没有更多数据了！"];
        } else {
            if(finished) finished(response, dict);
        }
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failed:^(NSURLResponse *response, NSError *error) {
        if (failed) failed(response, error);
        [SVProgressHUD showErrorWithStatus:@"加载失败，网络故障！"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

// 用于刷新
+ (void)getWithURL3:(NSString *)url targetVC:(UIViewController *)targetVC finished:(void(^)(NSURLResponse *response, NSDictionary *responseDict))finished failed:(void(^)(NSURLResponse *response, NSError *error))failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [WTRequestCenter getWithURL:url parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dict = JSON_TO_DICT(data);
        if(finished) finished(response, dict);
        [SVProgressHUD showSuccessWithStatus:@"刷新成功"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failed:^(NSURLResponse *response, NSError *error) {
        if (failed) failed(response, error);
        [SVProgressHUD showErrorWithStatus:@"刷新失败，网络故障！"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

+ (NSDictionary *)remarkTypeDictionary {
    return @{
             @(RemarkSymbolTypeProducts)     : @"ProductList",
             @(RemarkSymbolTypeCombo)        : @"ComboList",
             @(RemarkSymbolTypePreferential) : @"SaleList",
             @(RemarkSymbolTypeGroup)        : @"GroupList",
             @(RemarkSymbolTypeHotProducts)  : @"HotList",
             @(RemarkSymbolTypeRecommend)    : @"RecommendList"
             };
}

+ (void)b_getWithURL1:(NSString *)url targetVC:(UIViewController *__weak)targetVC finished:(void (^)(NSURLResponse *, NSDictionary *))finished failed:(void (^)(NSURLResponse *, NSError *))failed {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    __weak __typeof(&*targetVC)VC = targetVC;
    UIView *bg = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    bg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"left_view_bg"]];
    [VC.view addSubview:bg];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:VC.view animated:YES];
    hud.labelText = @"正在加载中";
    [hud setYOffset:-30];
    [WTRequestCenter getWithURL:url parameters:nil finished:^(NSURLResponse *response, NSData *data) {
        NSDictionary *dict = JSON_TO_DICT(data);
        if ([dict[@"result"] isKindOfClass:[NSString class]]) {
            [[self class] dataEmptyTryViewWithType:@"black" VC:targetVC];
            [bg removeFromSuperview];
        } else {
            if ([dict[@"result"] count] == 0) {
                [[self class] dataEmptyTryViewWithType:@"black" VC:targetVC];
                [bg removeFromSuperview];
            } else {
                if (finished) finished(response, dict);
                hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
                hud.labelText = @"加载成功";
                hud.mode = MBProgressHUDModeCustomView;
                [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:0 animations:^{
                    bg.alpha = 0;
                } completion:^(BOOL finished) {
                    [bg removeFromSuperview];
                }];
            }
        }
        [hud hide:YES afterDelay:0.5];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    } failed:^(NSURLResponse *response, NSError *error) {
        if (failed) failed(response, error);
        TryViewFactory <TryViewFactory> *connectErrorBackTryViewFactory = [[ConnectErrorBackTryViewFactory alloc] init];
        [connectErrorBackTryViewFactory createTryViewWithTargetView:targetVC.view clickedCallBack:^(TryView *tryView) {
            [[self class] b_getWithURL1:url targetVC:VC finished:finished failed:failed];
            [UIView animateKeyframesWithDuration:0.5 delay:0.5 options:0 animations:^{
                bg.alpha = 0;
            } completion:^(BOOL finished) {
                [bg removeFromSuperview];
            }];
            [tryView removeFromSuperview];
        }];
        [hud hide:YES afterDelay:0.5];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
}

@end
