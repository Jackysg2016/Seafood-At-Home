//
//  ShoppingCarToolBarView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/2.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCarToolBarView : UIView

@property (strong, nonatomic) UIButton *checkboxButton;
@property (strong, nonatomic) UILabel *sumLabel;
@property (strong ,nonatomic) UIButton *buyButton;
@property (strong, nonatomic) UIButton *deleteButton;

- (void)setAmount:(int)amount;

- (void)setSum:(float)sum;

+ (CGFloat)height;


/**
 *  设置成编辑状态
 */
- (void)editing;

/**
 *  设置成非编辑状态
 */
- (void)unediting;

@end
