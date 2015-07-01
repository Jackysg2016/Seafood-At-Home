//
//  RootViewController.h
//  Seafood
//
//  Created by 伟明 毕 on 14/12/6.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "TPKeyboardAvoidingTableView.h"
#import "TPKeyboardAvoidingCollectionView.h"

/**
 *  根视图控制器类，一切普通视图控制器都继承此类。
 */
@interface RootViewController : UIViewController
<
    UITableViewDataSource,
    UITableViewDelegate,
    UIScrollViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout
>

/**
 *  根视图TableView，它可以作为所有的视图控制器的根视图。
 *  @see initializationTableView
 */
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingTableView *tableView;

/**
 *  根视图ScrollView，它可以作为所有的视图控制器的视图的的根视图。
 *  @see initializationScrollView
 */
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

/**
 *  根视图collectionView，它可以作为所有的视图控制器的视图的的根视图。
 *  @see initializationCollectionView
 */
@property (nonatomic, strong) IBOutlet TPKeyboardAvoidingCollectionView *collectionView;

/**
 *  在需要调用TableView作为根视图的时候，必须要进行对TableView的初始化
 */
- (void)initializationTableView;

/**
 *  在需要调用ScrollView作为根视图的时候，必须要进行对ScrollView的初始化
 */
- (void)initializationScrollView;

/**
 *  在需要调用CollectionView作为根视图的时候，必须要进行对CollectionView的初始化
 */
- (void)initializationCollectionView;

@end
