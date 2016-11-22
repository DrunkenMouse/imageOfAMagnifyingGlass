
//
//  ADOMaskImageView.m
//  图像的放大镜
//
//  Created by 王奥东 on 16/11/17.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "ADOMaskImageView.h"

@implementation ADOMaskImageView
//触摸
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _thumImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _thumImageView.center = point;
    [self addSubview:_thumImageView];
    //获取触摸点放大后的图像
    UIImage *image = [self getImageInPoint:point];
    _thumImageView.image = image;
    //放大镜图片形状
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[[UIImage imageNamed:@"2.png"] CGImage];
    mask.frame = CGRectMake(0, 0, 70, 70);
    _thumImageView.layer.mask = mask;
    _thumImageView.layer.masksToBounds = YES;
}

//移动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    _thumImageView.center = point;
    
    //获取移动时，坐标点对应的放大后图像
    UIImage *image = [self getImageInPoint:point];
    _thumImageView.image = image;
    
    CALayer *mask = [CALayer layer];
    mask.contents = (id)[[UIImage imageNamed:@"2.png"] CGImage];
    mask.frame = CGRectMake(0, 0, 70, 70);
    _thumImageView.layer.mask = mask;
    _thumImageView.layer.masksToBounds = YES;
    //如果坐标点不在自身范围内，就不显示放大镜与放大后图像
    if (!CGRectContainsPoint(self.bounds, point)) {
        [_thumImageView removeFromSuperview];
        _thumImageView = nil;
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_thumImageView) {
        [_thumImageView removeFromSuperview];
        _thumImageView = nil;
    }
}
//获取图像
-(UIImage *)getImageInPoint:(CGPoint)point{
    //放大镜左上角的坐标点
    //获取自身图像的x，y点相对应的大图坐标，减去放大镜的一半尺寸
    UIImage *bigImage = [UIImage imageNamed:@"1.png"];
    
    CGFloat x = point.x * bigImage.size.width / self.frame.size.width - 35;
    CGFloat y = point.y * bigImage.size.height / self.frame.size.height - 35;
    CGRect rect = CGRectMake(x, y, 70, 70);
    //通过上下文获取对应的大图坐标所对应rect的图像
    CGImageRef imageRef = bigImage.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, rect);
    
    CGSize size;
    size.width = 70;
    size.height = 70;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, rect, subImageRef);
    
    UIImage *smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}

@end
