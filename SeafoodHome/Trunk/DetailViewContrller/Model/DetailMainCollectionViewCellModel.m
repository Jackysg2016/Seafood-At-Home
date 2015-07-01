//
//  DetailMainCollectionViewCellModel.m
//  SeafoodHome
//
//  Created by btw on 14/12/22.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "DetailMainCollectionViewCellModel.h"

@implementation DetailMainCollectionViewCellModel

- (id)initWithDictionary:(NSDictionary *)dictionary {
    if (self = [super initWithDictionary:dictionary]) {
        NSMutableArray *imagesURLArray = [[NSMutableArray alloc] init];
        if (dictionary[@"app_imagesURLArray"]) {
            for (NSString *url in dictionary[@"app_imagesURLArray"]) {
                [imagesURLArray addObject:[NSURL URLWithString:url]];
            }
        }
        self.imagesURLArray = imagesURLArray;
    }
    return self;
}

+ (DetailMainCollectionViewCellModel *)modelWithDictionary:(NSDictionary *)dictionary {
    DetailMainCollectionViewCellModel *model = [[DetailMainCollectionViewCellModel alloc] initWithDictionary:dictionary];
    return model;
}

@end
