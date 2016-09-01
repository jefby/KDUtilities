//
//  KDAView.h
//  Surge Dashboard
//
//  Created by Blankwonder on 7/8/16.
//  Copyright © 2016 Yach. All rights reserved.
//
#if TARGET_OS_MAC

#import <Cocoa/Cocoa.h>

//IB_DESIGNABLE
@interface KDAView : NSView

@property (nonatomic) IBInspectable NSColor *backgroundColor;

@end
#endif

