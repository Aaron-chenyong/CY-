//
//  CYTabBar.m
//  百思不得姐
//
//  Created by chenyong on 16/4/27.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYTabBar.h"

@interface CYTabBar()
/**
 *  发布按钮
 */
@property (nonatomic, weak) UIButton *publishButton;
@end

@implementation CYTabBar

- (instancetype)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}


@end
