//
//  XZHImageLoader.h
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

typedef void(^XZHWebImageLoadFinishedBlock)(NSData *imageData, NSError *error, XZHImageCacheType cacheType, BOOL finished, NSURL *imageURL);

@interface XZHImageLoader : NSObject

- (id)downloadImageWithURL:(NSURL *)url completed:(XZHWebImageLoadFinishedBlock)completedBlock;

@end
