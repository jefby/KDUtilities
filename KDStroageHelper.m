//
//  KDStroageHelper.m
//  Beacon Calendar
//
//  Created by Blankwonder on 8/4/14.
//
//

#import "KDStroageHelper.h"
#import "KDLogger.h"


@implementation KDStroageHelper

+ (NSString *)documentDirectoryPath {
    static dispatch_once_t pred;
    __strong static id path = nil;
    
    dispatch_once(&pred, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = paths.firstObject;
    });
    return path;
}

+ (NSString *)libraryDirectoryPath {
    static dispatch_once_t pred;
    __strong static id libraryPath = nil;
    
    dispatch_once(&pred, ^{
        NSArray *libraryPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        libraryPath = libraryPaths.firstObject;
    });
    return libraryPath;
}

+ (NSString *)cacheDirectoryPath {
    static dispatch_once_t pred;
    __strong static id cachePath = nil;
    
    dispatch_once(&pred, ^{
        NSArray *cachePaths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        cachePath = cachePaths.firstObject;
    });
    return cachePath;
}

+ (NSString *)applicationSupportDirectoryPathWithName:(NSString *)name {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *path = [paths.firstObject stringByAppendingPathComponent:name];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    return path;
}

+ (NSString *)temporaryDirectoryPath {
    return NSTemporaryDirectory();
}

+ (NSString *)libraryDataStorageDirectoryPath {
    return [[self libraryDirectoryPath] stringByAppendingPathComponent:@"KDStroageHelper"];
}

+ (NSString *)pathForIdentifier:(NSString *)identifier {
    return [[self libraryDataStorageDirectoryPath] stringByAppendingPathComponent:identifier];
}

+ (void)writeDataToLibrary:(NSData *)data identifier:(NSString *)identifier {
    NSString *dir = [self libraryDataStorageDirectoryPath];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir]) {
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            KDClassLog(@"Error occurred when create directory: %@", error);
            return;
        }
    }
    [data writeToFile:[dir stringByAppendingPathComponent:identifier] atomically:YES];
    
    KDClassLog(@"Write data object: %@, bytes: %lu", identifier, data.length);
}

+ (NSData *)dataFromLibraryWithIdentifier:(NSString *)identifier {
    return [NSData dataWithContentsOfFile:[[self libraryDataStorageDirectoryPath] stringByAppendingPathComponent:identifier]];
}

+ (void)deleteDataFromLibraryWithIdentifier:(NSString *)identifier {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[self pathForIdentifier:identifier] error:&error];
    if (error) {
        KDClassLog(@"Error occurred when delete item: %@", error);
    }
}

+ (void)deleteAllData {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:[self libraryDataStorageDirectoryPath] error:&error];
    if (error) {
        KDClassLog(@"Error occurred when delete all data: %@", error);
    }
}

+ (NSDate *)dataModificationDateWithIdentifier:(NSString *)identifier {
    NSError *error = nil;
    NSDictionary *info = [[NSFileManager defaultManager] attributesOfItemAtPath:[self pathForIdentifier:identifier] error:&error];
    return [info fileModificationDate];
}

+ (void)setDataModificationDate:(NSDate *)date identifier:(NSString *)identifier {
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] setAttributes:@{NSFileModificationDate:date}
                                          ofItemAtPath:[self pathForIdentifier:identifier]
                                                 error:&error]) {
        KDClassLog(@"Error occurred whn set modification date: %@", error);
    }
}

@end
