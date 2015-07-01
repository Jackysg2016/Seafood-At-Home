//
//  BWMMoviewPlayerViewController.m
//  9SKG
//
//  Created by mac on 14-11-6.
//  Copyright (c) 2014年 9SKG. All rights reserved.
//

#import "BWMMoviewPlayerViewController.h"
#import "ALMoviePlayerController.h"
#import "SIAlertView.h"

@interface BWMMoviewPlayerViewController () <ALMoviePlayerControllerDelegate>
{
    ALMoviePlayerController *_playerController;
}
@end

@implementation BWMMoviewPlayerViewController

- (instancetype)initWithContentURL:(NSURL *)contentURL {
    if (self = [super init]) {
        self.contentURL = contentURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playerController = [[ALMoviePlayerController alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, SCREEN_WIDTH)];
    _playerController.delegate = self;
    
    //create the controls
    ALMoviePlayerControls *movieControls = [[ALMoviePlayerControls alloc] initWithMoviePlayer:_playerController style:ALMoviePlayerControlsStyleFullscreen];
    [movieControls setBarHeight:49.0f];
    [movieControls setBarColor:MAIN_YELLOW_COLOR];
    [movieControls setTimeRemainingDecrements:YES];
    
    //assign controls
    [_playerController setControls:movieControls];
    [self.view addSubview:_playerController.view];
    
    _playerController.view.transform = CGAffineTransformMakeRotation(M_PI / 2.0f);
    _playerController.view.center = self.view.center;
    movieControls.targetDelegate = self;
    
    [_playerController setContentURL:_contentURL];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark- ALMoviePlayerControllerDelegate
- (void)moviePlayerWillMoveFromWindow {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)movieTimedOut {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"错误提示" andMessage:@"视频加载超时！"];
    [alertView addButtonWithTitle:@"退出" type:SIAlertViewButtonTypeCancel handler:^(SIAlertView *alertView) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    alertView.transitionStyle = SIAlertViewTransitionStyleBounce;
    [alertView show];
}

@end
