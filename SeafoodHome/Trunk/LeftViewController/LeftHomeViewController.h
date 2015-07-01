//
//  LeftHomeViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewHomeBottomCell.h"
#import "LeftViewHomeHeaderCell.h"
#import "LeftViewHomeCoverCell.h"
#import "LeftViewHomeStrongColumnCell.h"
#import "LeftAddressViewController.h"
#import "LeftSettingViewController.h"

/**
 *  左边侧滑栏目视图控制器——主页
 */
@interface LeftHomeViewController : LeftViewController
<
    LeftViewHomeCoverCellDelegate,
    LeftViewHomeStrongColumnCellDelegate,
    LeftViewHomeHeaderCellDelegate,
    LeftViewHomeBottomCellDelegate
>

@end
