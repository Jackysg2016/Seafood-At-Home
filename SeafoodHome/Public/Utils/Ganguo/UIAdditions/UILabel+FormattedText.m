//
//  UILabel+FormattedText.m
//  DailyMovieReview
//
//  Created by Joao Costa on 3/1/13.
//  Copyright (c) 2013 none. All rights reserved.
//

#import "UILabel+FormattedText.h"

@implementation UILabel (FormattedText)

- (void)setTextColor:(UIColor *)textColor range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSForegroundColorAttributeName
                 value: textColor
                 range: range];
    
    [self setAttributedText: text];
}

- (void)setFont:(UIFont *)font range:(NSRange)range
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedText];
    [text addAttribute: NSFontAttributeName
                 value: font
                 range: range];
    
    [self setAttributedText: text];
}

- (void)setLineSpace:(CGFloat)space
{
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineSpacing = space;
    [text addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
    [self setAttributedText: text];
}

@end
