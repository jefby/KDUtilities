//
//  KDLineView.m
//  Starrank
//
//  Created by Blankwonder on 5/17/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import "KDLineView.h"
#import "KDUtilities.h"

@implementation KDLineView

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    if (self.lineColor) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
        CGContextSetLineWidth(context, KDUtilOnePixelSize());
        CGContextMoveToPoint(context, 0.0f, 0.0f);
        
        if (self.bounds.size.width > self.bounds.size.height) {
            CGContextAddLineToPoint(context, self.bounds.size.width, 0);
        } else {
            CGContextAddLineToPoint(context, 0, self.bounds.size.height);
        }
        
        CGContextStrokePath(context);
    }
}

@end
