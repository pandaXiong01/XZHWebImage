//
//  XZHImageCache.h
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, XZHImageCacheType) {
    /**
     * 没有缓存，网络请求下来
     */
    XZHImageCacheTypeNetworking,
    /**
     * 磁盘中读出
     */
    XZHImageCacheTypeDisk,
    /**
     * 内存中读出
     */
    XZHImageCacheTypeMemory
};

/**
 *  单例 负责在memory与disk存储
 */
@interface XZHImageCache : NSObject


+ (XZHImageCache *)sharedImageCache;

- (void)writeImageData:(NSData *)data forKey:(NSString *)fileName;

/**
 *  将下载的图片   从原始地址移动到 image文件夹
 *
 *  @param srcURL <#srcURL description#>
 *  @param key    <#key description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)moveImageDataName:(NSString *)fileName AtURL:(NSURL *)srcURL;

- (NSData *)readDataForKey:(NSString *)fileName;
- (void)readFileAsync:(NSString *)fileName complete:(void (^)(NSData *data, XZHImageCacheType cacheType))complete;

@end
