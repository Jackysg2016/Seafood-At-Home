//
//  BrandComboItemView.m
//  SeafoodHome
//
//  Created by btw on 15/1/14.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "BrandComboItemView.h"
#import "BrandCharacteristicComboModel.h"
#import "YoudaoTranslation.h"

@implementation BrandComboItemView

+ (BrandComboItemView *)view{
    BrandComboItemView *itemView = SELF_NIB;
    itemView.frame = CGRectMake(0, 0, 160, 215);
    itemView.clipsToBounds = YES;
    return itemView;
}

- (void)updateWithModel:(BrandCharacteristicComboModel *)model {
    [self.imageView sd_setImageWithURL:model.imageURL placeholderImage:WAIT_LOADING_IMAGE];
    self.cnTitleLabel.text = model.cnTitle;
    self.enTitleLabel.text = model.enTitle;
    self.imageView.clipsToBounds = YES;
    self.priceLabel.text = PRICE_STR(model.price);
    
    // 启用翻译
    if (model.enTitle.length == 0) {
        [YoudaoTranslation translationText:model.cnTitle resultCallBlack:^(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err) {
            if (resultText && err==nil) {
                self.enTitleLabel.text = resultText;
                model.enTitle = resultText;
            }
        }];
    }
}

@end