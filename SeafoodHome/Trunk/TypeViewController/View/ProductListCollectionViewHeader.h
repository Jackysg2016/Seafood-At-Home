//
//  ProductListCollectionViewHeader.h
//  SeafoodHome
//
//  Created by btw on 15/1/7.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewTypeTableHeaderView.h"


@interface ProductListCollectionViewHeader : UICollectionReusableView

@property (assign, nonatomic) id<MainViewTypeTableHeaderViewDelegate> delegate;

- (void)showButton;

- (void)hideButton;

@end
