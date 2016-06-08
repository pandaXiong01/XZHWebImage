//
//  EGOImageView.m
//  NewsDemo
//
//  Created by 熊志华 on 14/11/21.
//  Copyright (c) 2014年 熊志华. All rights reserved.
//

#import "EGOImageView.h"
#import "ImageLoader.h"

@interface EGOImageView () <ImageLoaderDelegate>
{
    id _target;//存储响应目标
    SEL _action;//存储响应对象方法
}
@end
@implementation EGOImageView
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //当actionView接收到触摸事件之后，通知target执行action方法，响应触摸事件
    [_target performSelector:_action withObject:self];//withObject跟参数
}
- (void)addTarget:(id)target action:(SEL)action {
    //保存外界指定的响应目标target以及行为action
    _target = target;
    _action = action;
}
//用来请求图片
- (void)setImageWithURLString:(NSString *)urlString placeHolderImage:(UIImage *)image {
    self.image = image; //显示默认加载图片
    ImageLoader *loader = [[ImageLoader alloc] init];
    loader.linkName = urlString; //设置请求地址
    loader.delegate = self;//设置代理
    [loader startLoadImage]; //开始下载图片

}
//图片请求完毕之后回调方法
- (void)finishImageLoadingWithData:(NSData *)data {
    self.image = [UIImage imageWithData:data];
}

@end
