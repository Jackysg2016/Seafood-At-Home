//
//  ProductListCollectionCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "ProductListCollectionCell.h"
#import "Masonry.h"
#import "YoudaoTranslation.h"

@implementation ProductListCollectionCell

- (void)awakeFromNib {
    _hexagramImageView.backgroundColor = [UIColor clearColor];
    _starView.backgroundColor = [UIColor clearColor];
    _bottomLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"product_list_line"]];
    _originalPriceLabel.strikeThroughEnabled = YES;
    
    [_buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_loveButton addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_unLoveButton addTarget:self action:@selector(unLoveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([self.reuseIdentifier isEqualToString:@"ProductListGridStyleCollectionCell"]) {
        _hexagramImageView.hexagramSize= HexagramSizeBig;
    }
    else {
        _hexagramImageView.hexagramSize = HexagramSizeSmall;
    }
}

- (void)updateCellWithModel:(ListAndDetailModel *)model delegate:(id<ProductListCollectionCellDelegate>)delegate {
    if (model) {
        _titleCNLabel.text = model.cnTitle;
        _titleENLabel.text = model.enTitle;
        if (!model.specification) model.specification = @"";
        _realPriceLabel.text = PRICE_TEXT(model.realPrice, model.specification);
        _originalPriceLabel.text = PRICE_TEXT(model.originalPrice, model.specification);
        _hexagramImageView.imageURL = [NSURL URLWithString:model.imageURLStr];
        _starView.rank = model.rank;
        [_loveButton setTitle:[NSString stringWithFormat:@"%d", model.loveCount] forState:UIControlStateNormal];
        [_unLoveButton setTitle:[NSString stringWithFormat:@"%d", model.unloveCount] forState:UIControlStateNormal];
        
        // combo特有的
        if (model.itemsArray) {
            // 提取ComboItem的图片
            NSMutableArray *imagesURLArray = [[NSMutableArray alloc] init];
            for (ListAndDetailComboItemModel *comboModel in model.itemsArray) {
                [imagesURLArray addObject:comboModel.imageURL];
            }
            [_comboProductListCollectionView updateUIWithImagesURLDataArray:imagesURLArray delegate:self];
        }
        if (model.descText) {
            _detailLabel.text = model.descText;
            [_detailLabel sizeToFit];
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(@-22);
                }];
            }
        }
    }
    
    _delegate = delegate;
    
    // 启用翻译
    if (model.enTitle.length==0) {
        [YoudaoTranslation translationText:model.cnTitle resultCallBlack:^(YoudaoTranslation *obj, NSString *prefixText, NSString *resultText, NSError *err) {
            if (resultText && err==nil) {
                _titleENLabel.text = resultText;
                model.enTitle = resultText;
            }
        }];
    }
    
}

#pragma mark- Button Method

- (void)buyButtonClicked:(UIButton *)button {
    if (_delegate) [_delegate productListCollectionCell:self buyButtonClicked:button];
}

- (void)loveButtonClicked:(UIButton *)button {
    if (_delegate) [_delegate productListCollectionCell:self loveButtonClicked:button];
}

- (void)unLoveButtonClicked:(UIButton *)button {
    if (_delegate) [_delegate productListCollectionCell:self unloveButtonClicked:button];
}

#pragma mark- ScrollHexagramProductCollectionViewDelegate
- (void)scrollHexagramProductCollectionView:(ScrollHexagramProductCollectionView *)collectionView clickedIndex:(int)clickedIndex {
    [_delegate productListCollectionCell:self comboProductClicked:clickedIndex];
}

@end