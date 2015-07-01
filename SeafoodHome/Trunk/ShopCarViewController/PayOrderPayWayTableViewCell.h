//
//  PayOrderPayWayTableViewCell.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/4.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 这是一个选择支付方式的TableViewCell */
@interface PayOrderPayWayTableViewCell : UITableViewCell

/**
 *  单选按钮
 */
@property (strong, nonatomic) IBOutlet UIButton *singletonButton;

/**
 *  图片视图
 */
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;

/**
 *  标题Label
 */
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

/**
 *  更新UI用本地的图片名称和标题
 *
 *  @param imageNamed 本地图片的名称
 *  @param title      标题
 */
- (void)updateUIWithImageNamed:(NSString *)imageNamed title:(NSString *)title;

/**
 *  设置选中状态
 */
- (void)selecte;

/**
 *  设置未选中状态
 */
- (void)unSelecte;

/**
 *  获取单元格的高度
 *
 *  @return 单元格的高度值
 */
+ (CGFloat)height;

@end
