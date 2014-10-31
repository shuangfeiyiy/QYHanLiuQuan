//
//  QYHotBBSTableViewCell.h
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-31.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QYHotBBSTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avastarImageView;

@property (weak, nonatomic) IBOutlet UILabel *labelScreenName;
@property (weak, nonatomic) IBOutlet UILabel *labelDatetime;
@property (weak, nonatomic) IBOutlet UILabel *labelBBSContent;
@property (weak, nonatomic) IBOutlet UILabel *labelFavoriteCount;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewFavorite;

@property (strong, nonatomic) NSDictionary *cellData;
@end
