//
//  KDABridge.h
//  Surge Dashboard
//
//  Created by Blankwonder on 7/30/16.
//  Copyright © 2016 Yach. All rights reserved.
//
#if TARGET_OS_MAC
#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h>
@compatibility_alias NSLabel NSTextField;

@interface NSTextField (KDABridge)

@property (nonatomic, copy) NSString *text;

@end
#endif