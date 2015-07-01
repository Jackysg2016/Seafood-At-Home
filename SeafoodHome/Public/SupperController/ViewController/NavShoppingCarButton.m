//
//  NavShoppingCarButton.m
//  SeafoodHome
//
//  Created by btw on 15/1/19.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "NavShoppingCarButton.h"

@implementation NavShoppingCarButton

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super init]) {
        [self setImage:[UIImage imageNamed:@"default_nav_right_btn"] forState:UIControlStateNormal];
        self.frame = CGRectMake(0, 0, 24, 19.5);
        
    }
    return self;
}

@end
