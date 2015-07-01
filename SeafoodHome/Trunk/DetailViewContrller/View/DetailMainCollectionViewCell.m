//
//  DetailMainCollectionViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailMainCollectionViewCell.h"
#import "SFShareSDK.h"
#import "YoudaoTranslation.h"

@implementation DetailMainCollectionViewCell {
    NSArray *_testImages;
}

- (void)awakeFromNib {
    _browerView.backgroundColor = [UIColor clearColor];
    _hexagramImageView.backgroundColor = [UIColor clearColor];
    _starImageView.backgroundColor = [UIColor clearColor];
    _originalPriceLabel.strikeThroughEnabled = YES;
    _hexagramImageView.hexagramSize = HexagramSizeLarge;
    [self createUI];
    [self appendingTargetAction];
}

- (void)createUI {
    _detailImageBrowserScrollView = [DetailImageBrowserScrollView detailImageBrowserScrollViewWithFrame:CGRectMake(0, 0, AUTO_MATE_WIDTH(_browerView.width), _browerView.height) imagesURLArray:nil delegate:self];
    [_browerView addSubview:_detailImageBrowserScrollView];
}

- (void)appendingTargetAction {
    [_loveButton addTarget:self action:@selector(loveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_unloveButton addTarget:self action:@selector(unloveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn addTarget:self action:@selector(shareBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    _hexagramImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hexagramImageViewClicked:)];
    [_hexagramImageView addGestureRecognizer:tap];
}

#pragma mark- TargetActions

- (void)loveButtonClicked:(UIButton *)button {
    [_delegate detailMainCollectionViewCell:self buttonClickedType:DetailMainCollectionViewCellButtonTypeLove];
}

- (void)unloveButtonClicked:(UIButton *)button {
    [_delegate detailMainCollectionViewCell:self buttonClickedType:DetailMainCollectionViewCellButtonTypeUnlove];
}

- (void)buyButtonClicked:(UIButton *)button {
    [_delegate detailMainCollectionViewCell:self buttonClickedType:DetailMainCollectionViewCellButtonTypeBuy];
}

- (void)hexagramImageViewClicked:(UITapGestureRecognizer *)recognizer {
    [_delegate detailMainCollectionViewCell:self hexagramImageViewTaped:(HexagramImageView *)recognizer.view];
}

- (void)shareBtnClicked:(UIButton *)button {
    SFShareSDKModel *shareModel = [[SFShareSDKModel alloc] initWithTitle:_model.cnTitle
                                                             description:_model.descText
                                                                 content:_model.descText
                                                          defaultContent:_model.descText
                                                          imageURLString:_model.imageURLStr
                                                               URLString:nil
                                                                  sender:button];
    [SFShareSDK executeShareWithModel:shareModel];
}

#pragma mark- 更新UI

- (void)updateUIWithModel:(DetailMainCollectionViewCellModel *)model delegate:(id<DetailMainCollectionViewCellDelegate>)delegate {
    _model = model;
    
    _titleLabel.text = model.cnTitle;
    _titleENLabel.text = model.enTitle;
    _realPriceLabel.text = PRICE_TEXT(model.realPrice, model.specification);
    _originalPriceLabel.text = PRICE_TEXT(model.originalPrice, model.specification);
    _hexagramImageView.imageURL = [model.imagesURLArray firstObject];
    _starImageView.rank = model.rank;
    [_loveButton setTitle:[NSString stringWithFormat:@"%d", model.loveCount] forState:UIControlStateNormal];
    [_unloveButton setTitle:[NSString stringWithFormat:@"%d", model.unloveCount] forState:UIControlStateNormal];

    // 设置图片的集合
    [_detailImageBrowserScrollView updateWithImagesURLArray:model.imagesURLArray delegate:self];
    
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

#pragma mark- DetailImageBrowserScrollViewDelegate

- (void)detailImageBrowserScrollView:(DetailImageBrowserScrollView *)detailImageBrowserScrollView itemClickedAtIndex:(int)index {
//    [_hexagramImageView setImageURL:_model.imagesURLArray[index]];
    [_delegate detailMainCollectionViewCell:self itemClickedAtIndex:index];
}

@end
