//
//  BrandGoodProductCollectionViewCell.m
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "BrandGoodProductCollectionViewCell.h"
#import "BrandExcellenceProductModel.h"
#import "YoudaoTranslation.h"

@implementation BrandGoodProductCollectionViewCell

- (void)awakeFromNib
{
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.5f;
    self.layer.cornerRadius = 2.0f;
    self.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 2.0f;
    self.imageView.layer.masksToBounds = YES;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://pic2.nipic.com/20090505/230015_022143741_2.jpg"]  placeholderImage:WAIT_LOADING_IMAGE];
}


- (void)updateWithModel:(BrandExcellenceProductModel *)model {
    [self.imageView sd_setImageWithURL:model.imageURL  placeholderImage:WAIT_LOADING_IMAGE];
    self.titleLabel.text = model.cnTitle;
    self.enTitleLabel.text = model.enTitle;
    self.priceLabel.text = PRICE_TEXT(model.price, model.unit);
    
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

+ (CGSize)size
{
    return CGSizeMake(AUTO_MATE_WIDTH(150), 210);
}

@end
