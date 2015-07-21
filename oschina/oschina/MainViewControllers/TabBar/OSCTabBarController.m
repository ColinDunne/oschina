//
//  OSCTabBarController.m
//  oschina
//
//  Created by 钱辰 on 15/7/17.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import "OSCTabBarController.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"
#import "UIImage+Util.h"
#import "OptionButton.h"

#define kMainScreenHeight   [UIScreen mainScreen].bounds.size.height
#define kMainScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kDiameter           60


@interface OSCTabBarController ()

@property (nonatomic, assign) BOOL isPressed;
@property (nonatomic, strong) UIView *dimView;
@property (nonatomic, strong) UIImageView *blurView;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSMutableArray *optionButtons;

@end

@implementation OSCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[
                             [[UIViewController alloc] init],
                             [[UIViewController alloc] init],
                             [[UIViewController alloc] init],
                             [[UIViewController alloc] init],
                             [[UIViewController alloc] init]
                            ];
    NSArray *titles = @[@"综合", @"动弹", @"", @"发现", @"我"];
    NSArray *images = @[@"tabbar-news", @"tabbar-tweet", @"", @"tabbar-discover", @"tabbar-me"];
    [self.tabBar.items enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitle:titles[idx]];
        [item setImage:[UIImage imageNamed:images[idx]]];
        [item setSelectedImage:[UIImage imageNamed:[images[idx] stringByAppendingString:@"-selected"]]];
    }];
    [self.tabBar.items[2] setEnabled:NO];
    
    [self addCenterButtonWithImage:[UIImage imageNamed:@"tabbar-more"]];
    
    // 功能键相关
    _optionButtons = [[NSMutableArray alloc] init];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    
    NSArray *buttonTitles = @[@"文字", @"相册", @"拍照", @"语音", @"扫一扫", @"找人"];
    NSArray *buttonImages = @[@"tweetEditing", @"picture",@"shooting", @"sound", @"scan", @"search"];
    int buttonColors[] = {0xe69961, 0x0dac6b, 0x24a0c4, 0xe96360, 0x61b644, 0xf1c50e};
    
    for (int i = 0; i < 6; i++) {
        OptionButton *optionButton = [[OptionButton alloc] initWithTitle:buttonTitles[i]
                                                                   image:[UIImage imageNamed:buttonImages[i]]
                                                                andColor:[UIColor colorWithHex:buttonColors[i]]];
        optionButton.frame = CGRectMake((kMainScreenWidth / 6 * (i % 3 * 2 + 1) - (kDiameter + 16) / 2),
                                        kMainScreenHeight + 150 + i / 3 * 100,
                                        kDiameter + 16,
                                        kDiameter + [UIFont systemFontOfSize:14].lineHeight + 24);
        [optionButton.button setCornerRadius:kDiameter / 2];
        
        optionButton.tag = i;
        optionButton.userInteractionEnabled = YES;
        [optionButton addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapOptionButton:)]];
        
        [self.view addSubview:optionButton];
        [_optionButtons addObject:optionButton];
    }
}

- (void)addCenterButtonWithImage:(UIImage *)buttonImage {
    _centerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGPoint origin = [self.view convertPoint:self.tabBar.center toView:self.tabBar];
    CGSize buttonSize = CGSizeMake(self.tabBar.frame.size.width / 5 - 6, self.tabBar.frame.size.height - 4);
    _centerButton.frame = CGRectMake(origin.x - buttonSize.height / 2, origin.y - buttonSize.height / 2, buttonSize.height, buttonSize.height);
    
    [_centerButton setCornerRadius:buttonSize.height / 2];
    [_centerButton setBackgroundColor:[UIColor colorWithHex:0x24a83d]];
    [_centerButton setImage:buttonImage forState:UIControlStateNormal];
    [_centerButton addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabBar addSubview:_centerButton];
}

- (void)buttonPressed
{
    [self changeThebuttonStateAnimatedToOpen:_isPressed];
    
    _isPressed = !_isPressed;
}

- (void)changeThebuttonStateAnimatedToOpen:(BOOL)isPressed
{
    if (isPressed) {
        [self removeBlurView];
        
        [_animator removeAllBehaviors];
        
        for (int i = 0; i < 6; i++) {
            UIButton *button = _optionButtons[i];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(kMainScreenWidth / 6 * (i % 3 * 2 + 1),
                                                                                                      kMainScreenHeight + 200 + i / 3 * 100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC * (6 - i)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    } else {
        [self addBlurView];
        
        [_animator removeAllBehaviors];
        
        for (int i = 0; i < 6; i++) {
            UIButton *button = _optionButtons[i];
            [self.view bringSubviewToFront:button];
            
            UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem:button
                                                                         attachedToAnchor:CGPointMake(kMainScreenWidth / 6 * (i % 3 * 2 + 1),
                                                                                                      kMainScreenHeight - 200 + i / 3 * 100)];
            attachment.damping = 0.65;
            attachment.frequency = 4;
            attachment.length = 1;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.02 * NSEC_PER_SEC * (i + 1)), dispatch_get_main_queue(), ^{
                [_animator addBehavior:attachment];
            });
        }
    }
}

- (void)addBlurView
{
    _centerButton.enabled = NO;
    
    CGRect cropRect = CGRectMake(0, kMainScreenHeight - 270, kMainScreenWidth, kMainScreenHeight);
    UIImage *originaImage = [self.view updateBlur];
    UIImage *croppedBlurImage = [originaImage cropToRect:cropRect];
    
    _blurView = [[UIImageView alloc] initWithImage:croppedBlurImage];
    _blurView.frame = cropRect;
    _blurView.userInteractionEnabled = YES;
    [self.view addSubview:_blurView];
    
    _dimView = [[UIView alloc] initWithFrame:self.view.bounds];
    _dimView.backgroundColor = [UIColor blackColor];
    _dimView.alpha = 0.4;
    [self.view insertSubview:_dimView belowSubview:self.tabBar];
    
    [_blurView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    [_dimView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonPressed)]];
    
    [UIView animateWithDuration:0.25 animations:nil completion:^(BOOL finished) {
        if (finished) {
            _centerButton.enabled = YES;
        }
    }];
}

- (void)removeBlurView
{
    _centerButton.enabled = NO;
    
    self.view.alpha = 1;
    [UIView animateWithDuration:0.25 animations:nil completion:^(BOOL finished) {
        if (finished) {
            [_dimView removeFromSuperview];
            [_blurView removeFromSuperview];
            _dimView = nil;
            _blurView = nil;
            
            _centerButton.enabled = YES;
        }
    }];
}






































@end
