//
//  KDLabel.m
//  Xiaoyu
//
//  Created by Blankwonder on 1/8/16.
//  Copyright © 2016 Daxiang. All rights reserved.
//

#import "KDLabel.h"

@implementation KDLabel

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:rect];
    
    if (self.strikeThroughLineColor) {
        CGSize textSize = self.attributedText != nil ? self.attributedText.size : [[self text] KD_sizeWithAttributeFont:[self font]];
        
        CGFloat strikeWidth = textSize.width;
        
        CGRect lineRect;
        
        if ([self textAlignment] == NSTextAlignmentRight) {
            lineRect = CGRectMake(rect.size.width - strikeWidth, rect.size.height/2, strikeWidth, 1);
        } else if ([self textAlignment] == NSTextAlignmentCenter) {
            lineRect = CGRectMake(rect.size.width/2 - strikeWidth/2, rect.size.height/2, strikeWidth, 1);
        } else {
            lineRect = CGRectMake(0, rect.size.height/2, strikeWidth, 1);
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [self strikeThroughLineColor].CGColor);
        CGContextFillRect(context, lineRect);
    }
}

- (void)setStrikeThroughLineColor:(UIColor *)strikeThroughLineColor {
    _strikeThroughLineColor = strikeThroughLineColor;
    [self setNeedsDisplay];
}

@end
