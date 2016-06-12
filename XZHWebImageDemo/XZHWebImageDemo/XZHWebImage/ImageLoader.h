//
//  ImageLoader.h
//  NewsDemo
//
//  Created by 熊志华 on 14/11/21.
//  Copyright (c) 2014年 熊志华. All rights reserved.
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
 *  为什么图片不显示?
    1.没有请求地址.imgsrc.
    2.data没有创建.
    3.data没有拼接.didReceiveData:
    4.数据直接从本地读取.
 */
@protocol ImageLoaderDelegate <NSObject>
- (void)finishImageLoadingWithData:(NSData *)data;
@end
//图片异步缓存处理
//思想:先查找本地是否缓存有对应的图片,如果有,则从本地读取图片,如果没有,则从网络上请求图片,请求到图片之后存储到本地.
@interface ImageLoader : NSObject
@property (nonatomic, copy) NSString *linkName; //连接地址字符串
@property (nonatomic, weak) id<ImageLoaderDelegate> delegate;
- (void)startLoadImage; //开始下载图片
+ (void)clearCachesImage; //删除本地图片缓存
@end


