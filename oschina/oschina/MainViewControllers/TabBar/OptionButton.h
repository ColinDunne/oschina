//
//  OptionButton.h
//  oschina
//
//  Created by 钱辰 on 15/7/20.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionButton : UIView

@property (nonatomic, strong) UIView *button;

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image andColor:(UIColor *)color;

@end
