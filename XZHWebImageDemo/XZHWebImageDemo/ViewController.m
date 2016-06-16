//
//  ViewController.m
//  XZHWebImageDemo
//
//  Created by gonghuiiOS on 16/6/7.
//  Copyright © 2016年 熊志华. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "XZHFileManager.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kImageUrl   @"http://f.hiphotos.baidu.com/zhidao/pic/item/dbb44aed2e738bd4f69c4f49a58b87d6277ff90d.jpg"
//@"http://img2.imgtn.bdimg.com/it/u=4185450816,762308027&fm=11&gp=0.jpg"
/**
 *  @"http://upload.xingjibocai.net/2016/0509/1462771847561.jpg"
 @"http://img2.imgtn.bdimg.com/it/u=4185450816,762308027&fm=11&gp=0.jpg"
@"http://juto8.com/uploads/allimg/160425/1-160425201913946.jpg"
 @"http://img3.douban.com/view/photo/raw/public/p1898277563.jpg"
 @"http://img3.qianzhan123.com/news/201506/26/20150626-5975faa7f3eba434_600x5000.jpg"
 @"http://f.hiphotos.baidu.com/zhidao/pic/item/dbb44aed2e738bd4f69c4f49a58b87d6277ff90d.jpg"
 @"http://i1.download.fd.pchome.net/t_960x600/g1/M00/07/0E/ooYBAFM89eaIATUjABC5i4XQsrAAABcmAJa1TsAELmj439.jpg"
 @"http://img.ithome.com/newsuploadfiles/2014/11/20141126_225612_157.jpg"
 */

@interface ViewController ()<NSURLSessionDataDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenWidth)];
    [self.view addSubview:imageView];
    
    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadBtn.frame = CGRectMake(10, CGRectGetMaxY(imageView.frame)+20, 60, 30);
    loadBtn.backgroundColor = [UIColor redColor];
    [loadBtn addTarget:self action:@selector(handleDownloadPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    
    self.imageView = imageView;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleDownloadPicture {
    [self.imageView setImageWithURL:kImageUrl placeholderImageName:@"1"];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
