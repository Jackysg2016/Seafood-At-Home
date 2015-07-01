//
//  HomeMiddleProductListViewModel.h
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/11.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  首页中间的滚动列表视图的模型
 */
@interface HomeMiddleProductListViewModel : NSObject

@property (assign, nonatomic) int productID;
@property (assign, nonatomic) int breedID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSURL *imageURL;


@end
