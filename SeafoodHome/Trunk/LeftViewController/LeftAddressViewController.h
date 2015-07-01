//
//  LeftAddressViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/9.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftViewPostionHeaderCell.h"
#import "LeftViewPostionStrongCell.h"
#import "LeftViewTelphonePopupView.h"

/**
 *  左边侧滑栏目视图控制器——店铺地址
 */
@interface LeftAddressViewController : LeftViewController
<
    LeftViewPositionStrongCellDelegate,
    LeftViewTelphonePopupViewDelegate
>

@end
