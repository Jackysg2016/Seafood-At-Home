//
//  HexagramImageView.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/10.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 六角星的规格
 */
typedef enum
{
    HexagramSizeSmall = 0,
    HexagramSizeMiddle,
    HexagramSizeBig,
    HexagramSizeLarge
} HexagramSize;

/**
 *  六角星图片视图
 */
@interface HexagramImageView : UIView

/**
 *  图片的路径
 */
@property (nonatomic, strong) NSURL *imageURL;

/**
 *  内容图片
 */
@property (nonatomic, strong) UIImageView *contentImageView;

/**
 *  六角星形的规格
 *  @see HexagramSize
 */
@property (nonatomic, assign) HexagramSize hexagramSize;

/**
 *  工厂方法创建六角星图片视图对象
 *
 *  @param frame          需要设置的frmae
 *  @param hexagramSize   六角星的规格
 *  @param imageURLString 图片网址路径
 *
 *  @return 六角星图片视图对象
 */
+ (instancetype)hexagramImageViewWithFrame:(CGRect)frame hexagramSize:(HexagramSize)hexagramSize imageURL:(NSURL *)imageURL;

@end