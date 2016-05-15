//
//  CYRecommendUserCell.m
//  百思不得姐
//
//  Created by chenyong on 16/5/15.
//  Copyright © 2016年 PALMFUN. All rights reserved.
//

#import "CYRecommendUserCell.h"
#import "CYRecommendUser.h"
#import "UIImageView+WebCache.h"

@interface CYRecommendUserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end


@implementation CYRecommendUserCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setUser:(CYRecommendUser *)user
{
    _user = user;
    
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}



@end
