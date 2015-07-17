//
//  OSCTabBarController.m
//  oschina
//
//  Created by 钱辰 on 15/7/17.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import "OSCTabBarController.h"

@interface OSCTabBarController ()

@end

@implementation OSCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    NSArray *titles = @[@"综合", @"动弹", @"", @"发现", @"我"];
    NSArray *images = @[@"tabbar-news", @"tabbar-tweet", @"", @"tabber-discover", @"tabbar-me"];
}

@end
