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
        CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
        
        if (self.bounds.size.width > self.bounds.size.height) {
            CGContextFillRect(context, CGRectMake(0, 0, self.bounds.size.width, 1.0 / self.contentScaleFactor));
        } else {
            CGContextFillRect(context, CGRectMake(0, 0, 1.0 / self.contentScaleFactor, self.bounds.size.height));
        }
    }
}

@end
