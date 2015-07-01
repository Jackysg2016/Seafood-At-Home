//
//  LeftViewHomeBottomCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/14.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewHomeBottomCellDelegate;

/**
 *  左视图首页的底部Cell样式
 */
@interface LeftViewHomeBottomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) id<LeftViewHomeBottomCellDelegate> delegate;

@end


@protocol LeftViewHomeBottomCellDelegate <NSObject>

- (void)leftViewHomeBottomCellTaped:(LeftViewHomeBottomCell *)cell;

@end