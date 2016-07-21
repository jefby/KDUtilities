//
//  KDAView.m
//  Surge Dashboard
//
//  Created by Blankwonder on 7/8/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import "KDAView.h"

@implementation KDAView

- (void)setBackgroundColor:(NSColor *)backgroundColor {
    _backgroundColor = backgroundColor;
    
    [self setNeedsDisplay:YES];
}

- (void)drawRect:(NSRect)dirtyRect {
    [_backgroundColor setFill];
    NSRectFill(dirtyRect);
}

- (BOOL)isOpaque {
    return YES;
}

@end
