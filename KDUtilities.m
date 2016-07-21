//
//  KDCUtil.c
//  koudaixiang
//
//  Created by Liu Yachen on 2/13/12.
//  Copyright (c) 2012 Suixing Tech. All rights reserved.
//

#import "KDUtilities.h"
#if TARGET_OS_IOS
#import "KDAlertView.h"
#endif

extern NSNumber *KDUtilIntegerValueNumberGuard(id obj) {
    if (!obj) return nil;
    if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return @([(NSString *)obj integerValue]);
    }
    return nil;
}

extern NSString *KDUtilStringGuard(id obj) {
    if (!obj) return nil;
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *)obj stringValue];
    }
    return nil;
}

@implementation NSObject (KDUtilitiesNotNull)

- (BOOL)KD_notNull {
    return self != [NSNull null];
}

@end

#if !TARGET_OS_IOS
extern BOOL KDUtilIsOSMajorVersionHigherOrEqual(int version) {
    static int OSMajorVersion;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        Gestalt(gestaltSystemVersionMinor, &OSMajorVersion);
#pragma clang diagnostic pop
    });
    
    return OSMajorVersion >= version;
}
#endif

#if TARGET_OS_IOS
#import "KDAlertView.h"
#endif

extern void KDAssert(BOOL eval, NSString *format, ...) {
    va_list ap;
    va_start(ap, format);
    if (!eval) {
#if TARGET_OS_IOS
        Class class = NSClassFromString(@"KDAlertView");
        if (class) {
            NSString *message = [[NSString alloc] initWithFormat:format arguments:ap];
            [[[class alloc] initWithTitle:@"Fatal Error" message:message cancelButtonTitle:@"OK" cancelAction:nil] show];
        }
#endif
#if DEBUG
        [NSException raise:NSInternalInconsistencyException format:format arguments:ap];
#endif
    }
    va_end(ap);
}

@implementation NSNumber (KDUtilities)

- (void)KD_forLoop:(void (^)(int i))block {
    int value = self.intValue;
    
    for (int i = 0; i < value; i++) {
        block(i);
    }
}

@end
