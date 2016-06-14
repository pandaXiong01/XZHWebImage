//
//  UIImageView+WebCache.m
//  XZHWebImageDemo
//
//  Created by 熊志华 on 15/6/7.
//  Copyright © 2016年 熊志华. All rights reserved.
//
#import "objc/runtime.h"
#import "UIImageView+WebCache.h"
#import "ImageLoader.h"

static const void *imageURLKey = &imageURLKey;

@interface UIImageView () <ImageLoaderDelegate>

@end

@implementation UIImageView (WebCache)
- (NSString *)imageURL {
    return objc_getAssociatedObject(self, imageURLKey);
}

- (void)setImageWithURL:(NSString *)url {
    [self setImageWithURL:url placeholderImageName:nil];
    
}

- (void)setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderName {
    
    [self setImageWithURL:url placeholderImageName:placeholderName options:nil];
}
/**
 *  <#Description#>
 *
 *  @param url             <#url description#>
 *  @param placeholderName <#placeholderName description#>
 *  @param options         预留参数 添加功能时会做更改
 */
- (void)setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderName options:(NSString *)options {
    
    objc_setAssociatedObject(self, imageURLKey, url, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (placeholderName) {
        UIImage *image = [UIImage imageNamed:placeholderName];
        self.image = image;
    }
    ImageLoader *loader = [[ImageLoader alloc] init];
    loader.linkName = url; //设置请求地址
    loader.delegate = self;//设置代理
    [loader startLoadImage]; //开始下载图片
    
}


@end
