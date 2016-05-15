//
//  CYRecommendUser.h
//  百思不得姐
//
//  Created by chenyong on 16/5/15.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYRecommendUser : NSObject
/**
 *  头像
 */
@property (nonatomic, copy) NSString *header;

/**
 *  粉丝数
 */
@property (nonatomic, assign) NSInteger fans_count;

/**
 *  昵称
 */
@property (nonatomic, copy) NSString *screen_name;

@end
