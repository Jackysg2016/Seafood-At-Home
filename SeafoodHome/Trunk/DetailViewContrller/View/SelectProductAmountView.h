//
//  SelectProductAmountView.h
//  SeafoodHome
//
//  Created by btw on 15/1/21.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 选择购买数量 */
@interface SelectProductAmountView : UIView <UITextFieldDelegate>

@property (assign, nonatomic) NSInteger currentAmount;
@property (assign, nonatomic) NSInteger maximumAmount;

@property (strong, nonatomic) IBOutlet UITextField *amountTextField;
@property (strong, nonatomic) IBOutlet UILabel *tipsLabel;
@property (strong, nonatomic) IBOutlet UILabel *maximumAmountLabel;

+ (SelectProductAmountView *)createView;


@end
