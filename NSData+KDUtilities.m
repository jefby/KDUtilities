//
//  NSData+KDUtilities.m
//  Kata
//
//  Created by Blankwonder on 6/27/15.
//  Copyright © 2015 Daxiang. All rights reserved.
//

#import "NSData+KDUtilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (KDUtilities)

- (NSString *)KD_MD5 {
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(self.bytes, (CC_LONG)self.length, md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
    
}

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
