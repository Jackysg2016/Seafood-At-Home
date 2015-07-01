//
//  TipsTableViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/27.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TipsModel;

typedef void(^ImageTapBlock)(NSInteger index);
@interface TipsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UILabel *imageTitle1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UILabel *imageTitle2;

- (void)updateWithModel:(TipsModel *)tipModel;

@property (assign, nonatomic) BOOL isOnDetailVC;

@property (copy, nonatomic) ImageTapBlock tapBlock;

@end
