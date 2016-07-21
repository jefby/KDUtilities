//
//  NWHUDView.m
//  Netpas Mac
//
//  Created by Blankwonder on 11/28/15.
//  Copyright © 2015 Netpas. All rights reserved.
//

#import "KDAHUDView.h"
#import <QuartzCore/QuartzCore.h>

@implementation KDAHUDView {
    NSProgressIndicator *_progressIndicator;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        _progressIndicator = [[NSProgressIndicator alloc] initWithFrame:NSMakeRect((frameRect.size.width - 32.0f) / 2.0f, (frameRect.size.height - 32.0f) / 2.0f, 32, 32)];
        _progressIndicator.style = NSProgressIndicatorSpinningStyle;
        _progressIndicator.controlTint = NSClearControlTint;
        [self addSubview:_progressIndicator];
        
        CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
        [lighten setDefaults];
        [lighten setValue:@1 forKey:@"inputBrightness"];
        [_progressIndicator setContentFilters:[NSArray arrayWithObjects:lighten, nil]];
        
        [_progressIndicator startAnimation:nil];
        
//        self.material = NSVisualEffectMaterialDark;
//        self.blendingMode = NSVisualEffectBlendingModeWithinWindow;
//        self.maskImage = [self maskImage:15 size:self.bounds.size];
        
        self.wantsLayer = YES;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithWhite:0 alpha:0.9] setFill];
    [[NSBezierPath bezierPathWithRoundedRect:self.bounds xRadius:5 yRadius:5] fill];
}

@end
