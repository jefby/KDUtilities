//
//  KDUtilities+iOS.m
//  Starrank
//
//  Created by Blankwonder on 6/8/16.
//  Copyright © 2016 Yach. All rights reserved.
//

#import "KDUtilities.h"

static NSComparisonResult _compareVersions(NSString* leftVersion, NSString* rightVersion) {
    int i;
    
    // Break version into fields (separated by '.')
    NSMutableArray *leftFields = [[NSMutableArray alloc] initWithArray:[leftVersion componentsSeparatedByString:@"."]];
    NSMutableArray *rightFields = [[NSMutableArray alloc] initWithArray:[rightVersion componentsSeparatedByString:@"."]];
    
    // Implict ".0" in case version doesn't have the same number of '.'
    if ([leftFields count] < [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [leftFields addObject:@"0"];
        }
    } else if ([leftFields count] > [rightFields count]) {
        while ([leftFields count] != [rightFields count]) {
            [rightFields addObject:@"0"];
        }
    }
    
    // Do a numeric comparison on each field
    for(i = 0; i < [leftFields count]; i++) {
        NSComparisonResult result = [leftFields[i] compare:rightFields[i] options:NSNumericSearch];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
}

BOOL KDUtilIsOSVersionHigherOrEqual(NSString* version) {
    return (_compareVersions([[UIDevice currentDevice] systemVersion], version) != NSOrderedAscending);
}

extern BOOL KDUtilIsOSMajorVersionHigherOrEqual(int version) {
    static int OSMajorVersion;
    static dispatch_once_t pred;
    
    dispatch_once(&pred, ^{
        OSMajorVersion = [[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."][0] intValue];
    });
    
    return OSMajorVersion >= version;
}
