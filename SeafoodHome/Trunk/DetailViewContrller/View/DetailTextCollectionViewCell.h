//
//  DetailTextCollectionViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailTextCollectionViewCellModel.h"

/**
 *  DetailCollectionView的下面部分
 */
@interface DetailTextCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *detailLabel;

- (void)updateWithModel:(DetailTextCollectionViewCellModel *)model;

@end
