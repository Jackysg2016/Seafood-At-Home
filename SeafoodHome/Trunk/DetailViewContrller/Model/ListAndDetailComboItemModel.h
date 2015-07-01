//
//  ComboItemModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 15/1/13.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  套餐类型特有的子Model
 */
@interface ListAndDetailComboItemModel : NSObject

@property (assign, nonatomic) int productID;
@property (strong, nonatomic) NSURL *imageURL;

@end
