//
//  XZHFileManager.h
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/13.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZHFileManager : NSObject
+ (XZHFileManager *)sharedFileManager;

- (NSData *)readFile:(NSString *)path;
- (void)readFileAsync:(NSString *)path complete:(void (^)(NSData *data))complete;

- (BOOL)writeFile:(NSString *)path data:(NSData *)data;
- (void)writeFileAsync:(NSString *)path data:(NSData *)data complete:(void (^)(BOOL result))complete;

@end
