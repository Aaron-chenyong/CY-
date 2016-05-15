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
#import "CYRecommendCategory.h"

#import "CYRecommendCategoryCell.h"

@interface CYRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  左边的类别数据
 */
@property (nonatomic, strong) NSArray *categories;
/**
 *  左边的类别表格TebleView
 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation CYRecommendViewController

static NSString * const CYCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册自定义cell
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([CYRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:CYCategoryId];
    
    self.title = @"推荐关注";
    
    //设置背景色
    self.view.backgroundColor = MYGlobalBg;
    
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


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CYCategoryId ];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}


@end
