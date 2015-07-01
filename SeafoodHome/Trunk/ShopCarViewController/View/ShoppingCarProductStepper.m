//
//  ShoppingCarProductStepper.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarProductStepper.h"
#import "ShoppingCarModel.h"

@interface ShoppingCarProductStepper() <UITextFieldDelegate>

@end

@implementation ShoppingCarProductStepper

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

// 创建UI
- (void)createUI {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(64, 10, 102, 21)];
    titleLabel.text = @"修改购买数量";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = MyFont(17.0);
    titleLabel.textAlignment= NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    _descendingButton = [[UIButton alloc] initWithFrame:CGRectMake(33, 37, 35, 30)];
    [_descendingButton setTitle:@"-" forState:UIControlStateNormal];
    [_descendingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _descendingButton.titleLabel.font = MyFont(16.0);
    [_descendingButton setBackgroundColor:RGB(243, 161, 33)];
    [_descendingButton addTarget:self action:@selector(descendingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_descendingButton];
    
    _ascendingButton = [[UIButton alloc] initWithFrame:CGRectMake(163, 37, 35, 30)];
    [_ascendingButton setTitle:@"+" forState:UIControlStateNormal];
    [_ascendingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _ascendingButton.titleLabel.font = MyFont(16.0);
    [_ascendingButton setBackgroundColor:RGB(243, 161, 33)];
    [_ascendingButton addTarget:self action:@selector(ascendingButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_ascendingButton];
    
    _amountTextField = [[UITextField alloc] initWithFrame:CGRectMake(67, 37, 97, 30)];
    _amountTextField.font = MyFont(16.0);
    _amountTextField.borderStyle = UITextBorderStyleNone;
    _amountTextField.layer.borderColor = RGB(243, 161, 33).CGColor;
    _amountTextField.layer.borderWidth = 2.0f;
    _amountTextField.placeholder = @"请输入数量";
    _amountTextField.textAlignment = NSTextAlignmentCenter;
    _amountTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_amountTextField addTarget:self action:@selector(amountTextFieldValueChanged:) forControlEvents:UIControlEventAllEditingEvents];
    
    [self addSubview:_amountTextField];
    
    UILabel *chSym = [[UILabel alloc] initWithFrame:CGRectMake(33, 69, 165, 19)];
    chSym.text = @"x";
    chSym.textAlignment = NSTextAlignmentCenter;
    chSym.textColor = [UIColor blackColor];
    chSym.font = MyFont(16.0f);
    [self addSubview:chSym];
    
    UILabel *equalSym = [[UILabel alloc] initWithFrame:CGRectMake(33, 110, 165, 19)];
    equalSym.text = @"＝";
    equalSym.textAlignment = NSTextAlignmentCenter;
    equalSym.textColor = [UIColor blackColor];
    equalSym.font = MyFont(16.0f);
    [self addSubview:equalSym];
    
    _unitPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 90, 165, 21)];
    _unitPriceLabel.text = PRICE_STR(0.0);
    _unitPriceLabel.textAlignment = NSTextAlignmentCenter;
    _unitPriceLabel.textColor = [UIColor blackColor];
    _unitPriceLabel.font = MyFont(16.0f);
    [self addSubview:_unitPriceLabel];
    
    _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(33, 131, 165, 21)];
    _sumLabel.text = PRICE_STR(0.0);
    _sumLabel.textAlignment = NSTextAlignmentCenter;
    _sumLabel.textColor = RGB(181, 48, 40);
    _sumLabel.font = MyFont(16.0f);
    [self addSubview:_sumLabel];
}

// 递减按钮点击事件
- (void)descendingButtonClicked:(UIButton *)button
{
    if (_model.amount > 1) {
        _model.amount --;
    }
    
    [self updateUIWithModel:_model];
}

// 递增按钮点击事件
- (void)ascendingButtonClicked:(UIButton *)button {
    if (_model.amount < _model.maximumAmount) {
        _model.amount ++;
    }
    
    [self updateUIWithModel:_model];
}

// 数量文本域改变事件
- (void)amountTextFieldValueChanged:(UITextField *)textField {
    int amount = [textField.text intValue];
    
    if (0 == amount) {
        amount = 1;
    } else if (amount > _model.maximumAmount) {
        amount = _model.maximumAmount;
    }
    
    textField.text = [NSString stringWithFormat:@"%d", amount];

    _model.amount = amount;
    
    [self updateUIWithModel:_model];
}

// 更新UI
- (void)updateUIWithModel:(ShoppingCarModel *)model {
    _model = model;
    
    _amountTextField.text = [NSString stringWithFormat:@"%d", model.amount];
    _unitPriceLabel.text = PRICE_STR(model.unitPrice);
    _sumLabel.text = PRICE_STR(model.sum);
}

+ (CGFloat)width {
    return 230;
}

+ (CGFloat)height {
    return 160;
}

@end
