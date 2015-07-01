//
//  HexagramImageView.m
//  SeafoodHome
//
//  Created by 伟明 毕 on 14/12/10.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "HexagramImageView.h"

static NSString * const kHexagramSmallImageNamed = @"hexagram_small";
static NSString * const kHexagramMiddleImageNamed = @"hexagram_middle";
static NSString * const kHexagramBigImageNamed = @"hexagram_big";
static NSString * const kHexagramLargeImageNamed = @"hexagram_large";

@implementation HexagramImageView
{
    UIImageView *_hexagramOverlayImageView;
}

+ (instancetype)hexagramImageViewWithFrame:(CGRect)frame hexagramSize:(HexagramSize)hexagramSize imageURL:(NSURL *)imageURL
{
    HexagramImageView *hexagramImageView = [[HexagramImageView alloc] initWithFrame:frame hexagramSize:hexagramSize imageURL:imageURL];
    return hexagramImageView;
}

- (id)initWithFrame:(CGRect)frame hexagramSize:(HexagramSize)hexagramSize imageURL:(NSURL *)imageURL
{
    if (self = [super initWithFrame:frame])
    {
        _hexagramSize = hexagramSize;
        _imageURL = imageURL;
        [self createContentImageView];
        [self createHexagramOverlayImageView];
    }
    return self;
}

- (void)awakeFromNib
{
    [self createContentImageView];
    [self createHexagramOverlayImageView];
}

- (void)createContentImageView
{
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    if (!_contentImageView)
    {
        _contentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _contentImageView.contentMode = UIViewContentModeScaleAspectFit;
        _contentImageView.backgroundColor = [UIColor whiteColor];
    }
    
    // SDWebImage Method...
    [_contentImageView sd_setImageWithURL:_imageURL  placeholderImage:WAIT_LOADING_IMAGE];
    
    [self addSubview:_contentImageView];
}

- (void)createHexagramOverlayImageView
{
    if (!_hexagramOverlayImageView)
    {
        _hexagramOverlayImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _hexagramOverlayImageView.contentMode = UIViewContentModeScaleToFill;
    }
    
    NSString *hexagramImageNamed = nil;
    switch (_hexagramSize)
    {
        case HexagramSizeSmall:
            hexagramImageNamed = kHexagramSmallImageNamed;
            break;

        case HexagramSizeMiddle:
            hexagramImageNamed = kHexagramMiddleImageNamed;
            break;
            
        case HexagramSizeBig:
            hexagramImageNamed = kHexagramBigImageNamed;
            break;
            
        case HexagramSizeLarge:
            hexagramImageNamed = kHexagramLargeImageNamed;
            break;

        default:
            break;
    }
    
    _hexagramOverlayImageView.image = [UIImage imageNamed:hexagramImageNamed];
    
    [self addSubview:_hexagramOverlayImageView];
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_contentImageView sd_setImageWithURL:_imageURL placeholderImage:WAIT_LOADING_IMAGE];
    
}

- (void)setHexagramSize:(HexagramSize)hexagramSize
{
    _hexagramSize = hexagramSize;
    
    [self createHexagramOverlayImageView];
}

@end
