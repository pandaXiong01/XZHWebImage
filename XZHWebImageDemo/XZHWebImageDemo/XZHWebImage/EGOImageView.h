//
//  EGOImageView.h
//  NewsDemo
//
//  Created by 熊志华 on 14/11/21.
//  Copyright (c) 2014年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EGOImageView : UIImageView
//用来请求图片
- (void)setImageWithURLString:(NSString *)urlString placeHolderImage:(UIImage *)image;

//给外界提供接口，获取触摸响应的目标（target）以及响应的方法（action）
- (void)addTarget:(id)target action:(SEL)action;

@end




