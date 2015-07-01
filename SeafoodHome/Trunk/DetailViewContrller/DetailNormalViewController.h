//
//  DetailViewController.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/21.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "DetailCollectionView.h"
#import "MWPhotoBrowser.h"
#import "SFAPILoader.h"


/**
 *  详情页视图控制器
 */
@interface DetailNormalViewController : MainViewController <DetailCollectionViewDelegate, MWPhotoBrowserDelegate>

- (instancetype)initWithProductID:(int)productID;
- (instancetype)initWithProductID:(int)productID remark:(RemarkSymbolType)remark;

@property (assign , nonatomic) int productID;
@property (assign, nonatomic) RemarkSymbolType remark;

/** 是否显示购物篮按钮 */
@property (assign, nonatomic) BOOL isShowShoppingCarButton;

/**
 * 专门用于特惠的SaleID
 */
@property (assign, nonatomic) NSInteger saleID;

@end