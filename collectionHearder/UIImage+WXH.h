//
//  UIImage+WXH.h
//  kkkkk
//
//  Created by kans on 16/3/3.
//  Copyright © 2016年 HaiYn. All rights reserved.
//

#import <UIKit/UIKit.h>
// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)


@interface UIImage (WXH)
/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithName:(NSString *)name;

/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;
@end
