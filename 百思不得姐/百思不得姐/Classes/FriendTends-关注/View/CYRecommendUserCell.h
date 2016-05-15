//
//  CYRecommendUserCell.h
//  百思不得姐
//
//  Created by chenyong on 16/5/15.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CYRecommendUser;

@interface CYRecommendUserCell : UITableViewCell
/**
 *  用户模型
 */
@property (nonatomic, strong) CYRecommendUser *user;
@end
