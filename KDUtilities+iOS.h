//
//  KDUtilities+iOS.h
//  Starrank
//
//  Created by Blankwonder on 6/8/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KDAssertRequireMainThread() KDAssert([NSThread isMainThread], @"This method can only be invoked on main thread!");
#define KDAssertRequirePad() KDAssert(KDUtilIsDevicePad(), @"This method can only be invoked on iPad!");
#define KDAssertRequireNotPad() KDAssert(!KDUtilIsDevicePad(), @"This method can not be invoked on iPad!");

NS_INLINE BOOL KDUtilIsDevicePad() {
    return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
}

extern BOOL KDUtilIsOSVersionHigherOrEqual(NSString* version);

NS_INLINE CGFloat KDUtilScreenWidth() {
    return [UIScreen mainScreen].bounds.size.width;
}

NS_INLINE CGFloat KDUtilOnePixelSize() {
    return 1.0f / [UIScreen mainScreen].scale;
}

NS_INLINE BOOL KDUtilIsDeviceJailbroken() {
#if TARGET_IPHONE_SIMULATOR
    return NO;
#endif
    NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libraryPath = libraryPaths.firstObject;
    
    NSArray *c = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[libraryPath substringFromIndex:libraryPath.length - 8] error:nil];
    return c.count != 0;
}
