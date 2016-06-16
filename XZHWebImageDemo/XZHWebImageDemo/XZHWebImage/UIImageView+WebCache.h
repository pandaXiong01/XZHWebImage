//
//  UIImageView+WebCache.h
//  XZHWebImageDemo
//
//  Created by 熊志华 on 15/6/7.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (WebCache)
/**
 *  返回imageUrl
 *
 *  @return imageUrl
 */
- (NSString *)imageURL;
/**
 *  直接设置WebUrl
 *
 *  @param url WebUrl
 */
- (void)setImageWithURL:(NSString *)url;
/**
 *  设置WebUrl,还设置placeholderImageName
 *
 *  @param url             WebUrl
 *  @param placeholderName placeholderImageName
 */
- (void)setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderName;


@end
