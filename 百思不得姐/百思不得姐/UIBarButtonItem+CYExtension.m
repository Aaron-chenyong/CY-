//
//  UIBarButtonItem+CYExtension.m
//  百思不得姐
//
//  Created by chenyong on 16/5/9.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "UIBarButtonItem+CYExtension.h"

@implementation UIBarButtonItem (CYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    //设置导航栏左边的按钮
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    
    [tagButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:tagButton];
}


@end
