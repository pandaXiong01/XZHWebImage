//
//  UIImageView+WebCache.h
//  XZHWebImageDemo
//
//  Created by 熊志华 on 15/6/7.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)

- (NSString *)imageURL;

- (void)setImageWithURL:(NSString *)url;

- (void)setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderName;


@end
