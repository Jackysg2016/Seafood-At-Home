//
//  LeftViewHomeHeaderCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewHomeHeaderCell.h"
#import "LeftHomeFavourBreedModel.h"

@interface LeftViewHomeHeaderCell()
{
    NSArray *_elements;
}
@end

@implementation LeftViewHomeHeaderCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    
    _elements = @[self.OneYuanBenefitsView, self.FullExcellentSeafoodView, self.FoodGoodsTipsView, self.ShopPositionView];
    
    for (int i = 0; i<_elements.count; i++)
    {
        ((UIView *)_elements[i]).tag = i;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonViewTaped:)];
        [_elements[i] addGestureRecognizer:tap];
    }
    
}

- (void)buttonViewTaped:(UITapGestureRecognizer *)recognizer
{
    if (_delegate)
    {
        [_delegate leftViewHomeHeaderCell:self buttonViewTapType:(int)recognizer.view.tag];
    }
}

- (void)updateWithModelArray:(NSArray *)modelArray {
    for (int i = 0; i<modelArray.count; i++) {
        LeftHomeFavourBreedModel *favourBreedModel = modelArray[i];
        UILabel *label = (UILabel *)[_elements[i] viewWithTag:10];
        label.text = favourBreedModel.breedTitle;
    }
}

@end
