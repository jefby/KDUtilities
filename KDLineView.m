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

- (void)_init {
    _lineColor = [UIColor colorWithWhite:0 alpha:0.1];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self _init];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    CGFloat width = 1.0 / self.contentScaleFactor;
    CGFloat yOffset = _alignToBottom ? self.bounds.size.height - width : 0;
    
    if (self.lineColor) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, self.lineColor.CGColor);
        
        if (self.bounds.size.width > self.bounds.size.height) {
            CGContextFillRect(context, CGRectMake(0, yOffset, self.bounds.size.width, width));
        } else {
            CGContextFillRect(context, CGRectMake(0, yOffset, width, self.bounds.size.height));
        }
    }
}

@end
