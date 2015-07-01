//
//  SelectProductAmountView.m
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "SelectProductAmountView.h"

@implementation SelectProductAmountView

+ (SelectProductAmountView *)createView {
    SelectProductAmountView *amountView = SELF_NIB;
    amountView.frame = CGRectMake(0, 0, 300, 113);
    return amountView;
}

- (void)awakeFromNib {
    self.currentAmount = 1;
    self.amountTextField.delegate = self;
    [self.amountTextField addTarget:self action:@selector(amountTextFieldChanged:) forControlEvents:UIControlEventAllEditingEvents];
}

- (void)amountTextFieldChanged:(UITextField *)textField {
    NSInteger amount = [textField.text integerValue];
    if (amount > _maximumAmount) {
        self.maximumAmountLabel.hidden = YES;
        self.tipsLabel.hidden = NO;
        self.currentAmount = self.maximumAmount;
    } else {
        _currentAmount = amount;
        self.maximumAmountLabel.hidden = NO;
        self.tipsLabel.hidden = YES;
    }
}

- (IBAction)ascendingBtnClicked:(UIButton *)sender {
    if (self.currentAmount < self.maximumAmount) {
        self.currentAmount ++;
        self.tipsLabel.hidden = YES;
        self.maximumAmountLabel.hidden = NO;
    } else if (self.currentAmount == self.maximumAmount) {
        self.tipsLabel.hidden = NO;
        self.maximumAmountLabel.hidden = YES;
    }
}

- (IBAction)descendingBtnClicked:(id)sender {
    if (self.currentAmount > 1) {
        self.currentAmount --;
    }
    
    self.tipsLabel.hidden = YES;
    self.maximumAmountLabel.hidden = NO;
}

- (void)setCurrentAmount:(NSInteger)currentAmount {
    _currentAmount = currentAmount;
    _amountTextField.text = [NSString stringWithFormat:@"%d", (int)_currentAmount];
}

- (void)setMaximumAmount:(NSInteger)maximumAmount {
    _maximumAmount = maximumAmount;
    self.maximumAmountLabel.text = [NSString stringWithFormat:@"库存: %d", (int)_maximumAmount];
}
@end
