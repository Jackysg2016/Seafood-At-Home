//
//  LeftViewPostionHeaderCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeftAddressModel;

@interface LeftViewPostionHeaderCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *addressImageView;

@property (strong, nonatomic) IBOutlet UILabel *shopTitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopAddressLabel;

- (void)updateWithModel:(LeftAddressModel *)model;

@end
