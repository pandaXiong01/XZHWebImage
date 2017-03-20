//
//  ViewController.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/7.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kImageUrl   @"http://f.hiphotos.baidu.com/zhidao/pic/item/dbb44aed2e738bd4f69c4f49a58b87d6277ff90d.jpg"

@interface ViewController ()<NSURLSessionDataDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupSubviews];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupSubviews {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenWidth)];
    [self.view addSubview:imageView];
    
    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadBtn.frame = CGRectMake(10, CGRectGetMaxY(imageView.frame)+20, 60, 30);
    loadBtn.backgroundColor = [UIColor redColor];
    [loadBtn addTarget:self action:@selector(handleDownloadPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    
    self.imageView = imageView;
}
- (void)handleDownloadPicture {
    [self.imageView setImageWithURL:kImageUrl placeholderImageName:@"1"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
