//
//  UIBarButtonItem+CYExtension.h
//  百思不得姐
//
//  Created by chenyong on 16/5/9.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CYExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
