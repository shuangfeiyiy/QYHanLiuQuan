//
//  QYNormalBBSTableViewCell.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-31.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYNormalBBSTableViewCell.h"

@interface QYNormalBBSTableViewCell ()

@end


@implementation QYNormalBBSTableViewCell

- (void)awakeFromNib {
    UIButton *btnProfile = [UIButton buttonWithType:UIButtonTypeCustom];
    btnProfile.bounds = CGRectMake(0, 0, 20, 20);
    [btnProfile setBackgroundImage: [UIImage imageNamed:@"帖子-列表-收藏"] forState:UIControlStateNormal];
    [btnProfile setBackgroundImage:[UIImage imageNamed:@"帖子-列表-收藏-press"] forState:UIControlStateHighlighted];
    self.accessoryView = btnProfile;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.text = self.cellData[@"titile"];
}

@end
