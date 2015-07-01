//
//  LeftSettingViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewUserSettingHeaderView.h"
#import "LeftViewUserSettingCell.h"

/**
 *  左边侧滑栏目视图控制器——用户设置
 */
@interface LeftSettingViewController : LeftViewController
<
    LeftViewUserSettingHeaderViewDelegate,
    LeftViewUserSettingCellDelegate
>


@end
