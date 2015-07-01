//
//  ShoppingCarToolBarView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/2.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarToolBarView.h"
#import "Masonry.h"

@implementation ShoppingCarToolBarView
{
    UILabel *_sumTextLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = RGB(234, 237, 241);
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 0.3f;
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    UIColor *mainColor = RGB(210, 55, 55);
    
    _checkboxButton = [[UIButton alloc] initWithFrame:CGRectMake(8, 11, 62, 22)];
    [_checkboxButton setTitleColor:RGB(141, 139, 134) forState:UIControlStateNormal];
    [_checkboxButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [_checkboxButton setTitle:@"全选" forState:UIControlStateNormal];
    [_checkboxButton setImage:[UIImage imageNamed:@"product_list_unselected"] forState:UIControlStateNormal];
    [_checkboxButton setImage:[UIImage imageNamed:@"product_list_selected"] forState:UIControlStateSelected];
    [_checkboxButton setTitle:@"取消" forState:UIControlStateSelected];
    [_checkboxButton setImageEdgeInsets:UIEdgeInsetsMake(0, -16, 0, 0)];
    _checkboxButton.titleLabel.font = MyFont(14.0);
    [self addSubview:_checkboxButton];
    
    _sumTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(78, 11, 40, 21)];
    _sumTextLabel.textColor = mainColor;
    _sumTextLabel.text = @"总计:";
    _sumTextLabel.font = MyFont(16);
    [self addSubview:_sumTextLabel];
    _sumTextLabel.hidden = YES;
    
    _sumLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 11, 87, 21)];
    _sumLabel.textColor = mainColor;
    _sumLabel.font = MyFont(16);
    _sumLabel.text = PRICE_STR(0.0f);
    [self addSubview:_sumLabel];
    _sumLabel.hidden = YES;
    
    _buyButton = [[UIButton alloc] initWithFrame:CGRectMake(207, 8, 105, 28)];
    [_buyButton setBackgroundColor:mainColor];
    [_buyButton setTitleColor:RGB(239, 239, 244) forState:UIControlStateNormal];
    _buyButton.titleLabel.font = MyFont(14);
    _buyButton.layer.cornerRadius = 4.0f;
    _buyButton.layer.masksToBounds = YES;
    [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
    [self addSubview:_buyButton];
    
    _deleteButton = [[UIButton alloc] initWithFrame:_buyButton.frame];
    [_deleteButton setBackgroundColor:[UIColor darkGrayColor]];
    [_deleteButton setTitleColor:RGB(239, 239, 244) forState:UIControlStateNormal];
    _deleteButton.titleLabel.font = MyFont(14);
    _deleteButton.layer.cornerRadius = 4.0f;
    _deleteButton.layer.masksToBounds = YES;
    [_deleteButton setImage:[UIImage imageNamed:@"shop_car_del"] forState:UIControlStateNormal];
    [_deleteButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    [_deleteButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -3, 0)];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    _deleteButton.hidden = YES; // 默认隐藏
    [self addSubview:_deleteButton];
    
    // 设置约束
    [_sumTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(68);
        make.top.offset(11);
        make.width.equalTo(@40);
        make.height.equalTo(@21);
    }];
    
    [_sumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_sumTextLabel.mas_right).offset(2);
        make.right.equalTo(_buyButton.mas_left).offset(-4);
        make.top.equalTo(_sumTextLabel.mas_top);
        make.height.equalTo(_sumTextLabel.mas_height);
    }];
    
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.right.offset(-8);
        make.width.greaterThanOrEqualTo(@105);
        make.height.equalTo(@28);
    }];
    
    [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_buyButton.mas_top);
        make.right.equalTo(_buyButton.mas_right);
        make.width.equalTo(_buyButton.mas_width);
        make.height.equalTo(_buyButton.mas_height);
    }];

}

- (void)setAmount:(int)amount
{
    NSString *title = [NSString stringWithFormat:@"立即购买(%d)", amount];
    
    [_buyButton setTitle:title forState:UIControlStateNormal];
    
    NSString *deleteTitle = [NSString stringWithFormat:@"删除(%d)", amount];
    [_deleteButton setTitle:deleteTitle forState:UIControlStateNormal];
}

- (void)setSum:(float)sum
{
    _sumLabel.text = PRICE_STR(sum);
}

+ (CGFloat)height
{
    return 44.0f;
}

- (void)editing
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:nil completion:nil];
    
    _sumTextLabel.hidden = YES;
    _sumLabel.hidden = YES;
    _buyButton.hidden = YES;
    _deleteButton.hidden = NO;
}

- (void)unediting
{
    [UIView transitionWithView:self duration:0.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:nil completion:nil];
    
//    _sumTextLabel.hidden = NO;
//    _sumLabel.hidden = NO;
    _buyButton.hidden = NO;
    _deleteButton.hidden = YES;
}

@end
