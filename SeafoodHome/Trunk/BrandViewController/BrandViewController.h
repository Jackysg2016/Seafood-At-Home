//
//  BrandViewController.h
//  SeafoodHome
//
//  Created by btw on 15/1/5.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "MainViewController.h"
#import "iCarousel.h"

@interface BrandViewController : MainViewController
<
    iCarouselDataSource,
    iCarouselDelegate
>

@end
