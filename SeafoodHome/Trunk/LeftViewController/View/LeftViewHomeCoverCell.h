//
//  LeftViewHomeCoverCell.h
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftHomeScrollView.h"

@class LeftViewHomeCoverCell;

@protocol LeftViewHomeCoverCellDelegate <NSObject>

- (void)leftViewHomeCoverCell:(LeftViewHomeCoverCell *)cell clickedIndex:(int)clickedIndex;

@end

@interface LeftViewHomeCoverCell : UITableViewCell <LeftHomeScrollViewDelegate>

@property (strong, nonatomic) NSArray *imagesURLArray;
@property (assign, nonatomic) id<LeftViewHomeCoverCellDelegate> delegate;
@property (strong, nonatomic) LeftHomeScrollView *coverView;

/**
 *  创建UI
 *
 *  @param imagesURLArray   一个包含图片URL的数组
 *  @param delegate delegate
 */
- (void)createUIWithImagesURLArray:(NSArray *)imagesURLArray delegate:(id<LeftViewHomeCoverCellDelegate>)delegate;

@end
