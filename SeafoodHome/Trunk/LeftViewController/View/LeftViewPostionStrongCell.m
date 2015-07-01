//
//  LeftViewPostionStrongCell.m
//  SeafoodHome
//
//  Created by btw on 14/12/15.
//  Copyright (c) 2014年 beautyway. All rights reserved.
//

#import "LeftViewPostionStrongCell.h"

@interface LeftViewPostionStrongCell()
{
    NSMutableArray *_buttonViews;
}
@end

@implementation LeftViewPostionStrongCell


- (void)createUIWithDelegate:(id<LeftViewPositionStrongCellDelegate>)delegate
{
    if (_delegate)
    {
        return;
    }
    
    _buttonViews = [[NSMutableArray alloc] init];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.frame = CGRectMake(0, 0, AUTO_MATE_WIDTH(320-55), AUTO_MATE_WIDTH(72));
    self.backgroundColor = [UIColor clearColor];
    
    NSArray *icons = @[@"left_view_position_cur", @"left_view_position_gui", @"left_view_position_tel_off"];
    NSArray *highIcons = @[[NSNull null],[NSNull null], @"left_view_position_tel_on"];
    CGSize iconsSize[] = {{37/2.0, 47/2.0}, {49/2.0, 50/2.0}, {47/2.0, 47/2.0}};
    
    float buttonViewWidth = self.contentView.frame.size.width/3.0;
    
    for (int i = 0; i < 3; i++)
    {
        LeftViewPositionButtonView *buttonView = [LeftViewPositionButtonView leftViewPositionButtonViewWithFrame:CGRectMake(buttonViewWidth*i, 0, buttonViewWidth, self.contentView.frame.size.height) iconImageSize:iconsSize[i] iconImageNamed:icons[i] highlightedImageNamed:highIcons[i]];
        buttonView.tag = i;
        [self.contentView addSubview:buttonView];
        [_buttonViews addObject:buttonView]; // add to array
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonViewTaped:)];
        [buttonView addGestureRecognizer:tap];
    }
    
    _delegate = delegate;
    
}

- (void)buttonViewTaped:(UITapGestureRecognizer *)recognizer
{

    switch (recognizer.view.tag)
    {
        case 0:
            [_delegate leftViewPositionStrongCell:self buttonViewTapType:PositionStrongColumnTypeLocation buttonView:(LeftViewPositionButtonView *)recognizer.view];
            break;
        case 1:
            [_delegate leftViewPositionStrongCell:self buttonViewTapType:PositionStrongColumnTypeNavigation buttonView:(LeftViewPositionButtonView *)recognizer.view];
            break;
        case 2:
            [_delegate leftViewPositionStrongCell:self buttonViewTapType:PositionStrongColumnTypeTelephone buttonView:(LeftViewPositionButtonView *)recognizer.view];
            break;
    }
    
    if (((LeftViewPositionButtonView *)recognizer.view).iconImageView.highlighted)
    {
        ((LeftViewPositionButtonView *)recognizer.view).iconImageView.highlighted = NO;
    }
    else
    {
        for (LeftViewPositionButtonView *buttonView in _buttonViews)
        {
            if (recognizer.view == buttonView)
            {
                buttonView.iconImageView.highlighted = YES;
            }
            else
            {
                buttonView.iconImageView.highlighted = NO;
            }
        }
    }
    
    
}

@end
