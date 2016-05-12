//
//  DetailViewController.h
//  demo10_ImageReview
//
//  Created by LuoShimei on 16/5/12.
//  Copyright © 2016年 罗仕镁. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

/** 声明一个变量，接收传进的图片路径 */
@property(nonatomic,copy) NSString *imageNetPath;
/** 声明一个变量，接收传进的图片名字 */
@property(nonatomic,copy) NSString *imageName;

@end

