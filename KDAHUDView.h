//
//  NWHUDView.h
//  Netpas Mac
//
//  Created by Blankwonder on 11/28/15.
//  Copyright © 2015 Netpas. All rights reserved.
//
#if TARGET_OS_MAC
#import <Cocoa/Cocoa.h>

@interface KDAHUDView : NSView

+ (KDAHUDView *)showHUDInView:(NSView *)view;
+ (void)hideHUDInView:(NSView *)view;

@end
#endif
