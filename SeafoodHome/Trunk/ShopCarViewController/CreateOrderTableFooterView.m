//
//  CreateOrderTableFooterView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "CreateOrderTableFooterView.h"
#import "Masonry.h"

@interface CreateOrderTableFooterView()
<
    UITextFieldDelegate
>
{
    UIColor *tf_bg_color;
    NSArray *_textFields;
}
@end

@implementation CreateOrderTableFooterView

+ (instancetype)createOrderTableFooterViewWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate,UITextViewDelegate>)delegate
{
    CreateOrderTableFooterView *view = SELF_NIB;
    view.frame = frame;
    view.delegate = delegate;
    return view;
}

- (void)awakeFromNib
{
    tf_bg_color = [RGB(242, 240, 236) colorWithAlphaComponent:0.5];
    [self configUI];
}

- (void)configUI
{
    _separatorLine.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_to_down_shadow"]];
    
    _addressTV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _addressTV.layer.borderWidth = 1.0f;
    _addressTV.layer.cornerRadius = 3.0f;
    _addressTV.layer.masksToBounds = YES;
    _addressTV.showsHorizontalScrollIndicator = NO;
    _addressTV.showsVerticalScrollIndicator = NO;
    _addressTV.backgroundColor = tf_bg_color;
    _addressTV.delegate = _delegate;
    
    _commitBtn.layer.cornerRadius = 3.0f;
    _commitBtn.layer.masksToBounds = YES;
    
    // 修改TextField的外观
    _textFields = @[_contactsTF, _phoneNumberTF, _noteTF];
    for (UITextField *textField in _textFields)
    {
        textField.backgroundColor = tf_bg_color;
        textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
        textField.layer.borderWidth = 1.0f;
        textField.layer.cornerRadius = 3.0f;
        textField.layer.masksToBounds = YES;
        textField.delegate = _delegate;
    }
}


+ (CGFloat)height
{
    return 295.0f;
}

- (BOOL)resignFirstResponder
{
    
    return [super resignFirstResponder];;
}

@end
