//
//  XZHImageLoader.h
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XZHImageCache.h"

typedef void(^XZHWebImageLoadFinishedBlock)(NSData *imageData, NSError *error, XZHImageCacheType cacheType, BOOL finished, NSURL *imageURL);

@interface XZHImageLoader : NSObject

- (id)loadImageWithURL:(NSURL *)url completed:(XZHWebImageLoadFinishedBlock)completedBlock;

@end
