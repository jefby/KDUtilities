//
//  NSData+KDUtilities.m
//  Kata
//
//  Created by Blankwonder on 6/27/15.
//  Copyright © 2015 Daxiang. All rights reserved.
//

#import "NSData+KDUtilities.h"

@implementation NSData (KDUtilities)

- (NSString *)stringWithUTF8Encoding {
    return [self stringWithEncoding:NSUTF8StringEncoding];
}
- (NSString *)stringWithEncoding:(NSStringEncoding)encoding {
    return [[NSString alloc] initWithData:self encoding:encoding];
}

- (NSString *)stringValue {
    NSString *str = [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    if (!str) {
        str = [[NSString alloc] initWithData:self encoding:NSASCIIStringEncoding];
    }
    
    return str;
}

- (NSArray *)componentsSeparatedByData:(NSData *)separator {
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:10];
    
    NSRange range;
    NSUInteger previousLineEnd = 0;
    
    while ((range = [self rangeOfData:separator options:0 range:NSMakeRange(previousLineEnd, self.length - (previousLineEnd))]).location != NSNotFound) {
        NSData *lineData = [self subdataWithRange:NSMakeRange(previousLineEnd, range.location - previousLineEnd)];
        previousLineEnd = range.location + range.length;
        
        if (lineData.length > 0) {
            [datas addObject:lineData];
        }
    }
    
    if (previousLineEnd < self.length) {
        [datas addObject:[self subdataWithRange:NSMakeRange(previousLineEnd, self.length - previousLineEnd)]];
    }
    
    return datas;
}

@end
