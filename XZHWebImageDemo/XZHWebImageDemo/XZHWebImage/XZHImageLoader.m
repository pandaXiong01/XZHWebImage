//
//  XZHImageLoader.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHImageLoader.h"

@interface XZHImageLoader ()
@property (nonatomic, copy) XZHWebImageLoadFinishedBlock finishedBlock;
@end
@implementation XZHImageLoader


- (id)loadImageWithURL:(NSURL *)url completed:(XZHWebImageLoadFinishedBlock)completedBlock {
    
    //判断本地之前是否缓存过该图片
    XZHImageCache *imageCache = [XZHImageCache sharedImageCache];
    [imageCache readFileAsync:[url lastPathComponent] complete:^(NSData *data, XZHImageCacheType cacheType) {
        if (data) {
            completedBlock(data, nil, cacheType, YES, url);
        } else {
            [self downloadImageFromNetworkWithURL:url Completed:completedBlock];
        }
    }];

    return self;
}

- (void)downloadImageFromNetworkWithURL:(NSURL *)url Completed:(XZHWebImageLoadFinishedBlock)completedBlock {
    
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"线程:%@",[NSThread currentThread]);
        
#warning 判断之前是否存在
        //        NSFileManager *fileManager = [NSFileManager defaultManager];
        //        if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
        //            [fileManager removeItemAtURL:fileURL error:NULL];
        //        }

        
        NSData *data = [NSData dataWithContentsOfURL:location];
        if (data) {
            completedBlock(data, nil, XZHImageCacheTypeNetworking, YES, url);
            [[XZHImageCache sharedImageCache] moveImageDataName:[[response URL] lastPathComponent] AtURL:location];
        } else {
            completedBlock(nil, error, XZHImageCacheTypeNetworking, NO, url);
        }
        
    }];
    [downloadTask resume];

}

@end
