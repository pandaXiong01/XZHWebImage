//
//  XZHFileManager.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/13.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHFileManager.h"

//线程队列名称
static char *queueName = "fileManagerQueue";

@interface XZHFileManager ()
{
    //读写队列
    dispatch_queue_t _queue;
}
@end
@implementation XZHFileManager

+ (XZHFileManager *)sharedFileManager {
    static XZHFileManager *fileManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileManager = [[XZHFileManager alloc] init];
    });
    return fileManager;
    
}
/**
 *      
 NSString *documentRoot = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
 NSString *filePath = [documentRoot stringByAppendingPathComponent:@"test.txt"];

 */
- (instancetype)init
{
    if(self = [super init]) {
        _queue = dispatch_queue_create(queueName, DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (NSData *)readFile:(NSString *)path
{
    __block NSData *data;
    dispatch_sync(_queue, ^{
        if([[NSFileManager defaultManager] fileExistsAtPath:path]){
            data = [[NSFileManager defaultManager] contentsAtPath:path];
        }
    });
    return data;
}

- (void)readFileAsync:(NSString *)path complete:(void (^)(NSData *data))complete
{
    dispatch_async(_queue, ^{
        NSData *data = nil;
        
        if([[NSFileManager defaultManager] fileExistsAtPath:path]){
            data = [[NSFileManager defaultManager] contentsAtPath:path];
        }
        
        if (complete) {
            complete(data);
        }
    });
}

- (BOOL)writeFile:(NSString *)path data:(NSData *)data
{
    __block BOOL result = NO;
    dispatch_barrier_sync(_queue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:path]){
            [fileManager removeItemAtPath:path error:nil];
        }
        
        result = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        
        
        NSLog(@"写文件：");
    });
    return result;
}

- (void)writeFileAsync:(NSString *)path data:(NSData *)data complete:(void (^)(BOOL result))complete
{
    __block BOOL result = NO;
    dispatch_barrier_async(_queue, ^{
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if([fileManager fileExistsAtPath:path]){
            [fileManager removeItemAtPath:path error:nil];
        }
        
        result = [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
        
        if (complete) {
            complete(result);
        }
    });
    
}

@end
