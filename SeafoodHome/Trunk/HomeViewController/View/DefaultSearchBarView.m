//
//  DefaultSearchBarView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DefaultSearchBarView.h"
#import "FXBlurView.h"

static NSString *kPlaceholderText = @"搜索...";

@implementation DefaultSearchBarView

- (instancetype)initWithFrame:(CGRect)frame targetVC:(UIViewController *)targetVC delegate:(id<DefaultSearchBarViewDelegate>)delegate {
    if (self = [self initWithFrame:frame]) {
        self.delegate = delegate;
        self.targetVC = targetVC;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        CGRect newRect = frame;
        newRect.origin = CGPointZero;
        _defaultSearchTextField = [DefaultSearchTextField defaultSearchTextFieldWithFrame:frame];
        _defaultSearchTextField.delegate = self;
        [self addSubview:_defaultSearchTextField];
        
        // 键盘隐藏时触发，隐藏OverlayBackground
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeBlackBackgroundView) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

#pragma mark-

- (void)createBlackBackgroundView {
    if (_blackBackgroudView == nil) {
        _blackBackgroudView = [[FXBlurView alloc] initWithFrame:_targetVC.view.bounds];
        _blackBackgroudView.tintColor = [UIColor clearColor];
        _blackBackgroudView.dynamic = NO;
        _blackBackgroudView.blurRadius = 10.0f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blackBackgroundViewTap:)];
        _blackBackgroudView.userInteractionEnabled = YES;
        [_blackBackgroudView addGestureRecognizer:tap];
    }
    
    [_targetVC.view addSubview:_blackBackgroudView];
}

- (void)removeBlackBackgroundView {
    if (_blackBackgroudView) {
        [_blackBackgroudView removeFromSuperview];
    }
}

#pragma mark-

- (void)blackBackgroundViewTap:(UITapGestureRecognizer *)recognizer {
    [_defaultSearchTextField resignFirstResponder];
    [self removeBlackBackgroundView];
}

#pragma mark- UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([_defaultSearchTextField.text isEqualToString:kPlaceholderText]) {
        _defaultSearchTextField.text = @"";
    }
    
    [self createBlackBackgroundView];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_defaultSearchTextField.text isEqualToString:@""]) {
        _defaultSearchTextField.text = kPlaceholderText;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([_defaultSearchTextField.text isEqualToString:@""]) {
        _defaultSearchTextField.text = kPlaceholderText;
    } else {
        [_delegate defaultSearchBarView:self searchText:_defaultSearchTextField.text];
    }
    
    [_defaultSearchTextField resignFirstResponder];
    [self removeBlackBackgroundView];
    
    return YES;
}

- (void)clearText {
    _defaultSearchTextField.text = nil;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
