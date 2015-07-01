//
//  LeftViewPostionHeaderCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewPostionHeaderCell.h"
#import "LeftAddressModel.h"

@implementation LeftViewPostionHeaderCell

- (void)awakeFromNib {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
}

- (void)updateWithModel:(LeftAddressModel *)model {
    self.shopAddressLabel.text = model.shopAddress;
    self.shopTitleLabel.text = model.shopName;
    [self.addressImageView sd_setImageWithURL:model.shopAddressImageURL placeholderImage:WAIT_LOADING_IMAGE];
}

@end
