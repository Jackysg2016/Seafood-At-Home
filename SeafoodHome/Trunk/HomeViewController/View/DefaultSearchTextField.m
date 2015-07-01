//
//  DefaultSearchTextField.m
//  Seafood
//
//  Created by btw on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DefaultSearchTextField.h"

static NSString * const kPlaceholderText = @"搜索...";
static NSString * const kBackgroundImageNamed = @"default_searchbar_bg";
#define kTextColor RGB(204, 123, 6)
#define kBackgroundColor RGB(255, 192, 90)

@interface DefaultSearchTextField() <UITextFieldDelegate>
{
    UIView *_blackBackgroudView;
}
@end

@implementation DefaultSearchTextField

+ (instancetype)defaultSearchTextFieldWithFrame:(CGRect)frame
{
    DefaultSearchTextField *defaultSearchTextField = [[DefaultSearchTextField alloc] initWithFrame:frame];
    return defaultSearchTextField;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self configurationUI];
    }
    return self;
}

- (void)configurationUI
{
    self.keyboardType = UIKeyboardTypeDefault;
    self.returnKeyType = UIReturnKeySearch;
    self.layer.cornerRadius = 5.0f;
    self.text = kPlaceholderText;
    self.placeholder = kPlaceholderText;
    self.textColor = kTextColor;
    self.font = MyFont(14.0f);
    self.backgroundColor = kBackgroundColor;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
}

#pragma mark-

//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds , 10 , 0 );
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds , 10 , 0 );
}

@end
