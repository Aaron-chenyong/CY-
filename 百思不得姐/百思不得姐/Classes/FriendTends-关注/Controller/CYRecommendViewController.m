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
#import "MJRefresh.h"

#import "CYRecommendCategoryCell.h"
#import "CYRecommendCategory.h"
#import "CYRecommendUserCell.h"
#import "CYRecommendUser.h"

#define CYSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface CYRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;

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

    //添加刷新控件
    [self setupRefresh];
    
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

/**控件的初始化*/
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

/**添加刷新控件*/
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableView.mj_footer.hidden = YES;

}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    CYRecommendCategory *rc = CYSelectedCategory;
    
    //设置当前的页码为1
    rc.currentPage = 1;
    
    //请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
        //发送请求给服务器,加载右侧的数据
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //字典数组 转 模型数组
        NSArray *users = [CYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当期类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        //保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        if (rc.users.count == rc.total) {//全部加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MYLog(@"%@", error);
    }];
    
}
- (void)loadMoreUsers
{
    CYRecommendCategory *category = CYSelectedCategory;
    
    //发送请求给服务器,加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        //字典数组 转 模型数组
        NSArray *users = [CYRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //添加到当期类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        //刷新右边的表格
        [self.userTableView reloadData];
        
        //让底部控件结束刷新
        if (category.users.count == category.total) {//全部加载完毕
            [self.userTableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.userTableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MYLog(@"%@", error);
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {//左边的类别表格
        return self.categories.count;
    } else {//右边的用户表格
        //右边被选中的类别模型
       // CYRecommendCategory *Category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        NSInteger count = [CYSelectedCategory users].count;
        //每次刷新右边数据时,都控制footer显示或者隐藏
        self.userTableView.mj_footer.hidden = (count == 0);
        
        return count;
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
        //右边被选中的类别模型
        //CYRecommendCategory *Category = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        
        cell.user = [CYSelectedCategory users][indexPath.row];
        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYRecommendCategory *category = self.categories[indexPath.row];
    
    if(category.users.count) {
    //显示曾经加载过的数据
        [self.userTableView reloadData];
    } else {
        //赶紧刷新表格,目的是:马上显示Category的用户数据,不让用户看见上一个Category的残留数据
        [self.userTableView reloadData];
        
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    }
    

    
}


@end
