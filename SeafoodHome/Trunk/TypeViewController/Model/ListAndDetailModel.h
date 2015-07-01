//
//  ProductListCollectionCellModel.h
//  SeafoodHome
//
//  Created by btw on 14/12/18.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ListAndDetailComboItemModel.h"

/** 列表、内容页功用的Model */
@interface ListAndDetailModel : NSObject

@property (assign, nonatomic) int productID;
@property (assign, nonatomic) NSUInteger remark;
@property (strong, nonatomic) NSString *cnTitle;
@property (strong, nonatomic) NSString *enTitle;
@property (strong, nonatomic) NSString *imageURLStr;
@property (strong, nonatomic) NSString *descText;
@property (strong, nonatomic) NSString *descHTMLText;
@property (assign, nonatomic) float realPrice;
@property (assign, nonatomic) float originalPrice;
/** 900ml/瓶 */
@property (strong, nonatomic) NSString *specification;
/** 瓶 */
@property (strong, nonatomic) NSString *unit;
@property (assign, nonatomic) int loveCount;
@property (assign, nonatomic) int unloveCount;
@property (assign, nonatomic) int rank;
@property (strong, nonatomic) NSMutableArray *imagesURLArray;

/** 货存 */
@property (assign, nonatomic) unsigned int storeCount;

/** 下面是套餐特有的属性 */
@property (strong, nonatomic) NSArray *itemsArray;
/** 来源于哪个栏目的ID */
@property (assign, nonatomic) int typeID;

/** 是否套餐类型的NO是单品，YES是套餐 */
@property (assign, nonatomic) BOOL isPorc;

/** 有这个值的时候，添加购物篮的时候就用这个值作为productID添加 */
@property (assign, nonatomic) NSInteger saleID;

- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (ListAndDetailModel *)modelWithDictionary:(NSDictionary *)dictionary;

@end
