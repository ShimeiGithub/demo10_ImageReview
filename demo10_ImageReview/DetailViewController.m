//
//  DetailViewController.m
//  demo10_ImageReview
//
//  Created by LuoShimei on 16/5/12.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
/** 显示图片的空=控件 */
@property(nonatomic,strong) UIImageView *imageView;
/** 显示正在转圈加载的菊花 */
@property(nonatomic,strong) UIActivityIndicatorView *activityView;

/** 图片缓存的地址 */
@property(nonatomic,copy) NSString *imagesLocalPath;

@end

@implementation DetailViewController
/** 懒加载 */
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.center = self.view.center;
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView{
    if (_activityView == nil) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityView.center = self.view.center;
        _activityView.color = [UIColor blackColor];
    }
    return _activityView;
}

- (NSString *)imagesLocalPath{
    if (_imagesLocalPath == nil) {
        NSString *cachescPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
        //使用Component的好处就是文件夹会自动加'/'
        _imagesLocalPath = [cachescPath stringByAppendingPathComponent:@"images"];
        //不存在就创建文件夹
        if (![[NSFileManager defaultManager] fileExistsAtPath:_imagesLocalPath]) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:_imagesLocalPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                NSLog(@"缓存文件夹创建失败，error：%@",error);
            }
        }
    }
    return _imagesLocalPath;
}

- (void)downloadImage{
    NSString *lastComponent = self.imageNetPath.lastPathComponent;
    //图片的保存路径
    NSString *imageFilePath = [self.imagesLocalPath stringByAppendingString:lastComponent];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:imageFilePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:imageFilePath];
        self.imageView.image = image;
        return ;
    }
    
    
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(globalQueue, ^{
        //设置菊花转圈
        [self.activityView startAnimating];
        
        NSURL *url = [NSURL URLWithString:self.imageNetPath];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        
        //将下载好的图片的二进制数据保存
        [data writeToFile:imageFilePath atomically:YES];
        
        //图片的刷新需在主队列上进行
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            [self.activityView stopAnimating];
        });
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.imageName;
    
    //将视图添加到控制器上
    [self.imageView addSubview:self.activityView];
    [self.view addSubview:self.imageView];
    
    [self downloadImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
