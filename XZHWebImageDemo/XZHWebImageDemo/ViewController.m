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
#define kImageUrl   @"http://static.cpsdna.com/upload/vmaster/20160509/16050916355572426.PNG"
@interface ViewController ()<NSURLSessionDataDelegate>
@property (retain, nonatomic) NSMutableData *data;
@property(nonatomic,assign)long long currentLength;//存取当前获取数据的总长度
@property(nonatomic,assign)long long sumLength;//存取数据的总长度
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, retain) NSURLConnection *connection; //存储连接对象
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, kScreenWidth, kScreenWidth)];
//    [imageView setImageWithURL:@"1" placeholderImageName:kImageUrl];
    [self.view addSubview:imageView];
    
    UIButton *loadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loadBtn.frame = CGRectMake(10, CGRectGetMaxY(imageView.frame)+20, 60, 30);
    loadBtn.backgroundColor = [UIColor redColor];
    [loadBtn addTarget:self action:@selector(handleDownloadPicture) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loadBtn];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(loadBtn.frame)+10, CGRectGetMaxY(imageView.frame)+20, 80, 30)];
    label.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label];
    
    self.imageView = imageView;
    self.label = label;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)handleDownloadPicture {
    
    
    [self request];

}

- (void)request {
      NSURL *url = [NSURL URLWithString:kImageUrl];
    NSURLSessionDownloadTask *downloadTask = [[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"线程:%@",[NSThread currentThread]);
        
        // 设置文件的存放目标路径
        NSString *documentsPath = [self getDocumentsPath];
        ///Users/gonghui/Library/Developer/CoreSimulator/Devices/80264F1F-2057-4B69-9ECC-BC89DA985CF1/data/Containers/Data/Application/164D1545-71B7-4DA9-BDBE-8BE440768B34/Documents
        
        NSURL *documentsDirectoryURL = [NSURL fileURLWithPath:documentsPath];
        NSURL *fileURL = [documentsDirectoryURL URLByAppendingPathComponent:[[response URL] lastPathComponent]];
        // 如果该路径下文件已经存在，就要先将其移除，在移动文件
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:[fileURL path] isDirectory:NULL]) {
            [fileManager removeItemAtURL:fileURL error:NULL];
        }
        [fileManager moveItemAtURL:location toURL:fileURL error:NULL];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"updating UIImageView");
            self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        });
        
    }];
    [downloadTask resume];
    
}
- (NSString *)getDocumentsPath {
    NSArray *documents = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = documents[0];
    return documentsPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
