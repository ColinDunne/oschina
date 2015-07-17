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
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]]];
    }];
    [self.tabBar.items[2] setEnabled:NO];
}

@end
