//
//  TipsDetailViewController.m
//  SeafoodHome
//
//  Created by btw on 15/1/28.
//  Copyright (c) 2015年 beautyway. All rights reserved.
//

#import "TipsDetailViewController.h"
#import "TipsModel.h"
#import "TipsTableViewCell.h"
#import "ParallaxHeaderView.h"
#import "MWPhotoBrowser.h"
#import "SFVCProtocol.h"

static NSString * const kCellIdentity = @"TipsTableViewCell";

@interface TipsDetailViewController () <MWPhotoBrowserDelegate, SFVCProtocol>
{
    MWPhotoBrowser *_photoBrower;
}
@end

@implementation TipsDetailViewController

- (instancetype)initWithTipModel:(TipsModel *)tipModel {
    if (self = [super init]) {
        self.tipModel = tipModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
}

- (void)createUI {
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeBackButton];
    [self.UIHelper appendingNavTitleWithString:_tipModel.title];
    [self.UIHelper appendingNavElementWithType:ViewControllerUIHelperNavElementTypeShoppingCarButton];
    [self initializationTableView];
    
    if (!_photoBrower) {
        _photoBrower = [[MWPhotoBrowser alloc] initWithDelegate:self];
        [_photoBrower showNextPhotoAnimated:YES];
        [_photoBrower showPreviousPhotoAnimated:YES];
    }
}

- (void)initializationTableView {
    [super initializationTableView];
    
    [self.tableView registerNib:NIB_NAMED([TipsTableViewCell class]) forCellReuseIdentifier:kCellIdentity];
    
    if (self.tipModel.coverImageURL) {
        ParallaxHeaderView *headerView = [ParallaxHeaderView parallaxHeaderViewWithImage:WAIT_LOADING_IMAGE forSize:CGSizeMake(SCREEN_WIDTH, 250)];
        self.tableView.tableHeaderView = headerView;
        [[SDWebImageManager sharedManager] downloadImageWithURL:_tipModel.coverImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (finished && image) {
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^{
                    headerView.headerImage = image;
                    headerView.headerTitleLabel.text = _tipModel.title;
                });
            }
        }];
    }

}

#pragma mark- UITableViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.tableView) {
        [(ParallaxHeaderView *)self.tableView.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    cell.isOnDetailVC = YES;
    [cell updateWithModel:_tipModel];
    return [cell height];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TipsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentity];
    cell.isOnDetailVC = YES;
    [cell updateWithModel:_tipModel];
    cell.tapBlock =^ void (NSInteger index) {
        [_photoBrower setCurrentPhotoIndex:index];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_photoBrower];
        [self presentViewController:nav animated:YES completion:nil];
    };
    return cell;
}

#pragma mark- MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _tipModel.imagesURL.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    TipsImageModel *imageModel = _tipModel.imagesURL[index];
    MWPhoto *photo = [MWPhoto photoWithURL:imageModel.imageURL];
    photo.caption = _tipModel.title;
    return photo;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
   TipsImageModel *imageModel = _tipModel.imagesURL[index];
    MWPhoto *photo = [MWPhoto photoWithURL:imageModel.imageURL];
    return photo;
}

@end
