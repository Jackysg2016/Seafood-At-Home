//
//  FirstLaunchViewController.m
//  SeafoodHome
//
//  Created by btw on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "FirstLaunchViewController.h"
#import "SFUserDefaults.h"
#import "WindowRootViewController.h"
#import "PWParallaxScrollView.h"
#import "SMPageControl.h"
#import "SVProgressHUD.h"
#import "LetsGoViewController.h"

static NSString * const kPageControlCurrentImageNamed = @"launch_page_control_on";
static NSString * const kPageControlNormalImageNamed = @"launch_page_control_off";

@interface FirstLaunchViewController () <PWParallaxScrollViewDataSource, PWParallaxScrollViewDelegate> {
    SMPageControl *_pageControl;
}
@end

@implementation FirstLaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    // 创建界面
    [self createUserInterface];
}

#pragma mark- 创建界面

// 创建界面
- (void)createUserInterface {
    PWParallaxScrollView *scrollView = [[PWParallaxScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.dataSource = self;
    scrollView.backgroundColor = RGB(247, 176, 42);
    [self.view addSubview:scrollView];
    [scrollView reloadData];
    
    _pageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 20, self.view.frame.size.width, 10)];
    [_pageControl setCurrentPageIndicatorImage:[UIImage imageNamed:kPageControlCurrentImageNamed]];
    [_pageControl setPageIndicatorImage:[UIImage imageNamed:kPageControlNormalImageNamed]];
    [_pageControl setIndicatorMargin:10];
    [_pageControl setIndicatorDiameter:9];
    [_pageControl setNumberOfPages:4];
    [self.view addSubview:_pageControl];
    
}

// 根据图片名创建图片视图
- (UIImageView *)createImageViewWithImageNamed:(NSString *)imageNamed {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:imageNamed];
    imageView.contentMode = UIViewContentModeCenter;
    return imageView;
}

#pragma mark- PWParallaxScrollViewDelegate

// 创建N副图片
- (NSInteger)numberOfItemsInScrollView:(PWParallaxScrollView *)scrollView {
    return 4;
}

// 获取图片
- (UIView *)backgroundViewAtIndex:(NSInteger)index scrollView:(PWParallaxScrollView *)scrollView {
    NSString *imageNamed = [NSString stringWithFormat:@"launch_%d", (int)index];
    UIImageView *imageView = [self createImageViewWithImageNamed:imageNamed];
    imageView.backgroundColor = scrollView.backgroundColor;
    return imageView;
}

// ScrollVIew减速后回调
- (void)parallaxScrollView:(PWParallaxScrollView *)scrollView didEndDeceleratingAtIndex:(NSInteger)index {
    _pageControl.currentPage = index;
}

// 在最后一页点击后进行初始化并且进入主视图控制器
- (void)parallaxScrollView:(PWParallaxScrollView *)scrollView didRecieveTapAtIndex:(NSInteger)index {
    if (3 == index) {
        [SVProgressHUD showWithStatus:@"精彩盛宴即将开启..." maskType:SVProgressHUDMaskTypeClear];
        [[SFUserDefaults sharedUserDefaults] initializationUserData];
        // 1.5秒钟后跳转
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            LetsGoViewController *vc = [[LetsGoViewController alloc] init];
            [SVProgressHUD dismiss];
            [self.navigationController pushViewController:vc animated:YES];
        });
    } // end if
}

@end
