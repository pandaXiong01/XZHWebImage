//
//  XZHImageCache.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHImageCache.h"



@interface XZHImageCache ()
@property (strong, nonatomic) NSCache *imageDataCache;
@end

@implementation XZHImageCache

- (NSCache *)imageDataCache {
    if (!_imageDataCache) {
        self.imageDataCache = [[NSCache alloc] init];
    }
    return _imageDataCache;
}


+ (XZHImageCache *)sharedImageCache {
    static XZHImageCache *imageCache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageCache = [[XZHImageCache alloc] init];
    });
    return imageCache;

}
- (void)writeImageData:(NSData *)data forKey:(NSString *)key {
    [self.imageDataCache setObject:data forKey:key];
    NSString *filepath = [self filePathForKey:key];
    dispatch_queue_t fileQueue = dispatch_queue_create("my.imagefile.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(fileQueue, ^{
        [[NSFileManager defaultManager] createFileAtPath:filepath contents:data attributes:nil];
    });
//    [NSFileManager defaultManager]
}

- (NSData *)readDataForKey:(NSString *)key {
    if (key == nil) {
        return nil;
    }
    NSData *memoryData = [self.imageDataCache objectForKey:key];
    if (memoryData) {
        return memoryData;
    }
    
    NSString *filepath = [self filePathForKey:key];
    NSData *fileData = [[NSFileManager defaultManager] contentsAtPath:filepath];
    if (fileData) {
        [self.imageDataCache setObject:fileData forKey:key];
        return fileData;
    }
    
    return nil;
    
}
- (NSString *)filePathForKey:(NSString *)key {
    return @"filepath/";
}
@end
