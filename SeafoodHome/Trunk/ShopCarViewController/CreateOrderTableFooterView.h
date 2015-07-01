//
//  CreateOrderTableFooterView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/3.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  创建订单视图控制器的表格footer视图
 */
@interface CreateOrderTableFooterView : UIView

@property (weak, nonatomic) IBOutlet UIView *separatorLine;
@property (strong, nonatomic) IBOutlet UITextField *contactsTF;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (strong, nonatomic) IBOutlet UITextView *addressTV;
@property (strong, nonatomic) IBOutlet UITextField *noteTF;
@property (strong, nonatomic) IBOutlet UIButton *commitBtn;

@property (weak, nonatomic) id<UITextFieldDelegate, UITextViewDelegate> delegate;

+ (instancetype)createOrderTableFooterViewWithFrame:(CGRect)frame delegate:(id<UITextFieldDelegate, UITextViewDelegate>)delegate;

+ (CGFloat)height;

@end
