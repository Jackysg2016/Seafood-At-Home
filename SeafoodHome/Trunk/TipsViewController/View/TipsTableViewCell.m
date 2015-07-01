//
//  TipsTableViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "TipsTableViewCell.h"
#import "TipsModel.h"
#import "GGUtil.h"

@implementation TipsTableViewCell
{
    TipsModel *_model;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateWithModel:(TipsModel *)tipModel {
    _model = tipModel;
    
    self.titleLabel.text = tipModel.title;
    self.detailsLabel.text = [GGUtil filterHTML:tipModel.detail];
    self.timeLabel.text = tipModel.createDate;
    if (_isOnDetailVC) {
        self.detailsLabel.numberOfLines = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped:)];
        [self.imageView1 addGestureRecognizer:tap];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTaped:)];
        [self.imageView2 addGestureRecognizer:tap2];
    }
    
    [self.detailsLabel sizeToFit];
    // 设置图片
    if (tipModel.imagesURL.count == 0) {
        self.imageTitle1.hidden = YES;
        self.imageView2.hidden = YES;
        self.imageView1.hidden = YES;
        self.imageTitle2.hidden = YES;
    } else if (tipModel.imagesURL.count == 1) {
        TipsImageModel *imageModel1 = tipModel.imagesURL[0];
        [self.imageView1 sd_setImageWithURL:imageModel1.imageURL placeholderImage:WAIT_LOADING_IMAGE];
        self.imageTitle1.text = imageModel1.imageName;
        self.imageTitle1.hidden = NO;
        self.imageView1.hidden = NO;
        self.imageTitle2.hidden = YES;
        self.imageView2.hidden = YES;
    } else if (tipModel.imagesURL.count >= 2) {
        TipsImageModel *imageModel1 = tipModel.imagesURL[0];
        [self.imageView1 sd_setImageWithURL:imageModel1.imageURL placeholderImage:WAIT_LOADING_IMAGE];
        self.imageTitle1.text = imageModel1.imageName;
        TipsImageModel *imageModel2 = tipModel.imagesURL[1];
        [self.imageView2 sd_setImageWithURL:imageModel2.imageURL placeholderImage:WAIT_LOADING_IMAGE];
        self.imageTitle2.text = imageModel2.imageName;
        self.imageTitle1.hidden = NO;
        self.imageView1.hidden = NO;
        self.imageTitle2.hidden = NO;
        self.imageView2.hidden = NO;
    }

}

- (void)imageViewTaped:(UITapGestureRecognizer *)recognizer {
    if(_tapBlock) _tapBlock(recognizer.view.tag);
}

- (CGFloat)height {
    CGFloat height = 221.0f;
    if (_model.imagesURL.count == 0) {
        height -= 150;
    }
    height += self.detailsLabel.frame.size.height;
    
    return height;
}

@end
