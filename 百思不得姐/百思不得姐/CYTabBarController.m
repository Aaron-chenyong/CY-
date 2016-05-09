//
//  CYTabBarController.m
//  百思不得姐
//
//  Created by chenyong on 16/4/26.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYTabBarController.h"
#import "CYEssenceViewController.h"
#import "CYNewViewController.h"
#import "CYFriendTendsViewController.h"
#import "CYMeViewController.h"

#import "CYTabBar.h"

@interface CYTabBarController ()

@end

@implementation CYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //通过appearance统一设置所有UITabBarItem的文字属性
    //后面带有UI_APPEANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    //添加子控制器
    [self setupChildVc:[[CYEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[CYNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[CYFriendTendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
   [self setupChildVc:[[CYMeViewController alloc] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    //更换TabBar
    [self setValue:[[CYTabBar alloc] init] forKey:@"tabBar"];
}

//初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    UIImage *Seimage = [UIImage imageNamed:selectedImage];
    Seimage = [Seimage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = Seimage;
    
    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
    //包装一个导航控制器, 添加导航控制器为tabarcontroller的子控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    //添加到控制器
    [self addChildViewController:nav];
}




@end
