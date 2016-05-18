//
//  CYRecommendCategory.h
//  百思不得姐
//
//  Created by chenyong on 16/5/13.
//  Copyright © 2016年 PALMFUN. All rights reserved.
// 推荐关注左边的数据模型

#import <Foundation/Foundation.h>

@interface CYRecommendCategory : NSObject
/**
 "id"
 */
@property (nonatomic, assign) NSInteger id;
/**
 "name" 名字
 */
@property (nonatomic, copy) NSString *name;
/**
 "count" 总数
 */
@property (nonatomic, assign) NSInteger count;

/**
 *  这个类别对应的用户数据
 */
@property (nonatomic, strong) NSMutableArray *users;
/**总数*/
@property (nonatomic, assign) NSInteger total;
/**当前页码*/
@property (nonatomic, assign) NSInteger currentPage;


@end
