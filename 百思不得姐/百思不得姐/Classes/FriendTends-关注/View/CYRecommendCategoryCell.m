//
//  CYRecommendCategoryCell.m
//  百思不得姐
//
//  Created by chenyong on 16/5/13.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYRecommendCategoryCell.h"
#import "CYRecommendCategory.h"

@implementation CYRecommendCategoryCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = MYRGBColor(244, 244, 244);
}

- (void)setCategory:(CYRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
