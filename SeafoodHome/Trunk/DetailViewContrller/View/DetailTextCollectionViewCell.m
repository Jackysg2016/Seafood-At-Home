//
//  DetailTextCollectionViewCell.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailTextCollectionViewCell.h"

@implementation DetailTextCollectionViewCell

- (void)updateWithModel:(DetailTextCollectionViewCellModel *)model
{
    self.titleLabel.text = model.title;
    NSLog(@"%@", model.detail);
    self.detailLabel.text = model.detail;
    
    // 修复一些Bug
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 && [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        [self.detailLabel sizeToFit];
    }
}

@end
