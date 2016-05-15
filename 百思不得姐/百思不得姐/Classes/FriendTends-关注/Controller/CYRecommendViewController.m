//
//  CYRecommendViewController.m
//  百思不得姐
//
//  Created by chenyong on 16/5/13.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYRecommendViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "MJExtension.h"

#import "CYRecommendCategoryCell.h"
#import "CYRecommendCategory.h"
#import "CYRecommendUserCell.h"
#import "CYRecommendUser.h"

@interface CYRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;
/**
 *  右边的用户数据
 */
@property (nonatomic, strong) NSArray *users;

/**
 *  左边的类别表格TebleView
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

/**
 *  右边的用户表格TebleView
 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation CYRecommendViewController

static NSString * const CYCategoryId = @"category";
static NSString * const CYUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];

    //控件的初始化
    [self setupTableView];

    
    //显示指示器
    //提示用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
    
    //发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //隐藏指示器
        [MBProgressHUD hideHUD];
        
        
        //MYLog(@"%@",responseObject);
        //服务器返回的JSON数据
        self.categories = [CYRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                           
        //刷新表格
        [self.categoryTableView reloadData];
        
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //显示失败信息
        [MBProgressHUD showError:@"加载失败..."];
    }];
    
    
}

- (void)setupTableView
{
    //注册自定义cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CYCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:CYUserId];
    //设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    //设置标题
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = MYGlobalBg;

}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {//左边的类别表格
        return self.categories.count;
    } else {//右边的用户表格
        return self.users.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) {//左边的类别表格
    CYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CYCategoryId ];
    cell.category = self.categories[indexPath.row];
    return cell;
    }else{//右边的用户表格
        CYRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:CYUserId ];
        cell.user = self.users[indexPath.row];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYRecommendCategory *Category = self.categories[indexPath.row];
    
    //发送请求给服务器,加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(Category.id);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.users = [CYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];

        //刷新右边的表格
        [self.userTableView reloadData];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MYLog(@"%@", error);
    }];
    
}


@end
