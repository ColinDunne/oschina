//
//  UIView+Util.h
//  oschina
//
//  Created by 钱辰 on 15/7/21.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Util)

- (void)setCornerRadius:(CGFloat)cornerRadius;
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

- (UIImage *)convertViewToImage;
- (UIImage *)updateBlur;

@end
