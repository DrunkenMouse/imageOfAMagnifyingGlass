//
//  ViewController.m
//  图像的放大镜
//
//  Created by 王奥东 on 16/11/17.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ViewController.h"
#import "ADOMaskImageView.h"

@interface ViewController ()

@end

@implementation ViewController {
    //把子类当成父类来使用
    IBOutlet ADOMaskImageView *_maskImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [self scaleFromImage:[UIImage imageNamed:@"1"] toSize:CGSizeMake(231, 178)];
    _maskImageView.image = image;
}

//缩放图像
-(UIImage *)scaleFromImage:(UIImage *)image toSize: (CGSize) size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
