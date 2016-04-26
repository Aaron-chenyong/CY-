//
//  CYTabBarController.m
//  百思不得姐
//
//  Created by chenyong on 16/4/26.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYTabBarController.h"

@interface CYTabBarController ()

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加子控制器
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.tabBarItem.title = @"精华";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    vc01.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:vc01];
    
}



@end
