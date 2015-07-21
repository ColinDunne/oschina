//
//  OptionButton.m
//  oschina
//
//  Created by 钱辰 on 15/7/20.
//  Copyright (c) 2015年 com.qianchen. All rights reserved.
//

#import "OptionButton.h"
#import "UIView+Util.h"
#import "UIColor+Util.h"

@interface OptionButton ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation OptionButton

- (instancetype)initWithTitle:(NSString *)title image:(UIImage *)image andColor:(UIColor *)color
{
    if (self = [super init]) {
        _button = [[UIImageView alloc] init];
        _button.backgroundColor = color;
        
        _imageView = [[UIImageView alloc] initWithImage:image];
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [_button addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithHex:0x666666];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.text = title;
        
        [self addSubview:_button];
        [self addSubview:_titleLabel];
        
        [self setLayout];
    }
    return self;
}

- (void)setLayout
{
    for (UIView *view in self.subviews) {view.translatesAutoresizingMaskIntoConstraints = NO;}
    NSDictionary *views = NSDictionaryOfVariableBindings(_button, _titleLabel, _imageView);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_button]-8-[_titleLabel]-8-|" options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-8-[_button]-8-|" options:0 metrics:nil views:views]];
    [_button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-15-[_imageView]-15-|" options:0 metrics:nil views:views]];
    [_button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-15-[_imageView]-15-|" options:0 metrics:nil views:views]];
}

@end
