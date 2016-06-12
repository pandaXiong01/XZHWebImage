//
//  XZHImageCache.h
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZHImageCache : NSObject
- (void)writeImageData:(NSData *)data forKey:(NSString *)key;
- (NSData *)readDataForKey:(NSString *)key;

@end
