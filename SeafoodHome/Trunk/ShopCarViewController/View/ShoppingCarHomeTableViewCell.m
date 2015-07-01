//
//  ShoppingCarHomeTableViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/1.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "ShoppingCarHomeTableViewCell.h"
#import "HexagramImageView.h"
#import "ShoppingCarModel.h"
#import "Masonry.h"

@implementation ShoppingCarHomeTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    _checkBoxButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 30, 36, 60)];
    [_checkBoxButton setImage:[UIImage imageNamed:@"product_list_unselected"] forState:UIControlStateNormal];
    [_checkBoxButton setImage:[UIImage imageNamed:@"product_list_selected"] forState:UIControlStateSelected];
    [_checkBoxButton addTarget:self action:@selector(checkBoxButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_checkBoxButton];
    
    _myImageView =[HexagramImageView hexagramImageViewWithFrame:CGRectMake(36, 9, 87, 94) hexagramSize:HexagramSizeMiddle imageURL:nil];
    [self.contentView addSubview:_myImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 9, 166, 21)];
    _titleLabel.font = MyFont(14.0f);
    _titleLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_titleLabel];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(@135);
        make.top.mas_offset(@9);
        make.right.mas_offset(@-10);
    }];
    
    UILabel *unitPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 34, 36, 21)];
    unitPriceLabel.font = MyFont(12.0f);
    unitPriceLabel.text = @"单价:";
    unitPriceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:unitPriceLabel];
    
    UILabel *sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 60, 45, 21)];
    sizeLabel.font = MyFont(12.0f);
    sizeLabel.text = @"规格:";
    sizeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:sizeLabel];
    
    UILabel *amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(135, 85, 45, 21)];
    amountLabel.font = MyFont(12.0f);
    amountLabel.text = @"数量:";
    amountLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:amountLabel];
    
    _unitPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(172, 35, 123, 21)];
    _unitPriceLabel.font = MyFont(12.0f);
    _unitPriceLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_unitPriceLabel];
    
    _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 60, 123, 21)];
    _sizeLabel.font = MyFont(12.0f);
    _sizeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_sizeLabel];
    
    _amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 85, 123, 21)];
    _amountLabel.font = MyFont(12.0f);
    _amountLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_amountLabel];
    
    UIButton *changeAmountButton = [[UIButton alloc] initWithFrame:CGRectMake(133, 58, 60, 23)];
    [changeAmountButton setImage:[UIImage imageNamed:@"shop_car_edit"] forState:UIControlStateNormal];
    [changeAmountButton setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [changeAmountButton addTarget:self action:@selector(changeAmountButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:changeAmountButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 112, 300, 3)];
    lineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_list_line"]];
    [self.contentView addSubview:lineView];
    
    // config layout
    [changeAmountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@62);
        make.height.equalTo(@58);
        make.width.equalTo(@60);
        make.right.equalTo(@-3);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(112);
        make.left.offset(10);
        make.right.offset(-10);
        make.height.equalTo(@3);
    }];
}

- (void)updateViewWithModel:(ShoppingCarModel *)model delegate:(id<ShoppingCarHomeTableViewCellDelegate>)delegate
{
    _model = model;
    _delegate = delegate;
    
    _checkBoxButton.selected = model.isSelected;
    _myImageView.imageURL = model.imageURL;
    _titleLabel.text = model.title;
    _unitPriceLabel.text = PRICE_STR(model.unitPrice);
    _amountLabel.text = [NSString stringWithFormat:@"%d", model.amount];
    _sizeLabel.text = model.specification;
}

+ (CGFloat)height
{
    return 120.0f;
}

// 多选框点击事件
- (void)checkBoxButtonClicked:(UIButton *)button
{
    button.selected = !button.selected;
    [_delegate shoppingCarHomeTableViewCellCheckBoxButtonClicked:self model:_model button:button];
}

// 修改数量按钮点击事件
- (void)changeAmountButtonClicked:(UIButton *)button
{
    [_delegate shoppingCarHomeTableViewCellChangeAmountButtonClicked:self model:_model button:button];
}

@end
