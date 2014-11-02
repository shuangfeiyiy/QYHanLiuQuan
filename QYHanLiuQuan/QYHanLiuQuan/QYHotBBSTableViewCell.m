//
//  QYHotBBSTableViewCell.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-31.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYHotBBSTableViewCell.h"
#import "QYCommonDefine.h"
#import "UIImageView+WebCache.h"

@implementation QYHotBBSTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    //创建当前贴子用户的头像
    NSString *image = [self.cellData objectForKey:@"image"];
    [image stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
#if _DEBUG_
    NSString *imgString = [NSString stringWithFormat:@"%@%@",BASE_URL,image];
#endif
    NSString *imgString = @"http://tp1.sinaimg.cn/1922814940/180/5619966274/1";
    imgString = [imgString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self.avastarImageView setImageWithURL:[NSURL URLWithString:imgString]];
    self.avastarImageView.layer.cornerRadius = 15.0f;
    self.avastarImageView.layer.masksToBounds = YES;
    
    //创建当前贴子用户的名字
    [self.labelScreenName setText:[self.cellData objectForKey:@"author"]];
    [self.labelScreenName setNeedsDisplay];
    
    //热门贴子发贴时间
    [self.labelDatetime setText:[self.cellData objectForKey:@"date"]];
    
    //对此贴子回贴数量
    NSString *reply = @"67";
    [self.labelFavoriteCount setText:reply];
    
    //热门贴子的标题
    [self.labelBBSContent setText:[self.cellData objectForKey:@"titile"]];
}

@end
