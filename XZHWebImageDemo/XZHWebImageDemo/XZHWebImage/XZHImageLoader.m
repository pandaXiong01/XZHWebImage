//
//  XZHImageLoader.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/12.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "XZHImageLoader.h"

//线程队列名称
static char *queueName = "fileManagerQueue";
@interface XZHImageLoader ()
{
    //读写队列
    dispatch_queue_t _queue;
}

@property (nonatomic, strong) NSURL *imageURL; //连接地址字符串
@end
@implementation XZHImageLoader

- (id)downloadImageWithURL:(NSURL *)url completed:(XZHWebImageLoadFinishedBlock)completedBlock {
    self.imageURL = url;
    //判断本地之前是否缓存过该图片
    if ([self fileExists]) {
        //如果有缓存,则直接从本地读取.
        [self loadImageFromLocal];
    } else {
        //如果没有缓存,则从网络读取
        [self loadImageFromNetwork];
    }

    return self;
}
//从本地读取
- (void)loadImageFromLocal {
    
    NSData *data = [NSData dataWithContentsOfFile:[self getImagePath]];
    
}
//从网络上读取
- (void)loadImageFromNetwork {
    NSURL *url = self.imageURL;
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"线程:%@",[NSThread currentThread]);
        
        // 设置文件的存放目标路径
        NSString *documentsPath = [self getImagePath];
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
        NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
        // 如果该路径下文件已经存在，就要先将其移除，在移动文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
            [fileManager removeItemAtURL:fileURL error:NULL];
        }
        //移动到文件夹
        [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"updating UIImageView");
            //切换到主线程
            //self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        });
        
    }];
    [downloadTask resume];
    
    //    NSURL *url = [NSURL URLWithString:self.linkName];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
}


#pragma mark -------   file path -------
//判断本地之前是否缓存过该图片
- (BOOL)fileExists {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self getImagePath]]) {
        return YES;
    }
    return NO;
}
//获取图片文件路径
- (NSString *)getImagePath {
    NSString *imagePath = [self.imageURL lastPathComponent];
    return [[[self class] getCachesImagePath] stringByAppendingPathComponent:imagePath];
}
//获取Images文件夹路径
+ (NSString *)getCachesImagePath {
    //1.获取Caches文件夹的路径
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    //2.获取Images文件夹的路径
    NSString *imagesPath = [filePath stringByAppendingPathComponent:@"Images"];
    //3.判断文件夹是否存在
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:imagesPath]) {
        //没有,创建Images文件夹
        BOOL isSuccess = [manager createDirectoryAtPath:imagesPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (isSuccess) {
            NSLog(@"创建成功");
        } else {
            NSLog(@"创建失败");
        }
    }
    return imagesPath;
}

#pragma mark -----  clear caches
+ (void)clearCachesImage {
    NSFileManager *manager = [NSFileManager defaultManager];
    //删除文件夹
    [manager removeItemAtPath:[self getCachesImagePath] error:nil];
    //创建
    [self getCachesImagePath];
}

@end
