//
//  UIImage+Util.h
//  oschina
//
//  Created by 钱辰 on 15/7/20.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Util)

- (UIImage *)imageMaskedWithColor:(UIColor *)maskColor;

- (UIImage *)cropToRect:(CGRect)rect;

@end
