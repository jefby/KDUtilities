//
//  KDABridge.m
//  Surge Dashboard
//
//  Created by Blankwonder on 7/30/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import "KDABridge.h"
#if TARGET_OS_MAC

@implementation NSTextField (KDABridge)

- (NSString *)text {
    return self.stringValue;
}

- (void)setText:(NSString *)text {
    self.stringValue = text ?: @"";
}

@end
#endif