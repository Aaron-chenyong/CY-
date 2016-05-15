//
//  CYRecommendCategoryCell.m
//  百思不得姐
//
//  Created by chenyong on 16/5/13.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYRecommendCategoryCell.h"
#import "CYRecommendCategory.h"

@interface CYRecommendCategoryCell()
/**
 *  选中时显示的指示器控件
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end


@implementation CYRecommendCategoryCell

- (void)awakeFromNib {
 
    self.backgroundColor = MYRGBColor(244, 244, 244);
    self.selectedIndicator.backgroundColor = MYRGBColor(219, 21, 26);
    
    //当cell的selection为None时,即使cell被选中时,内部的子控件也不会进入高亮状态
//    self.textLabel.highlightedTextColor = MYRGBColor(219, 21, 26);

}

- (void)setCategory:(CYRecommendCategory *)category
{
    _category = category;
    
    self.textLabel.text = category.name;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //重新调整内部textLabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

/**
 *  该方法监听当前sell的选中 和 取消选中
 */
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : MYRGBColor(78, 78, 78);
    
}





@end
