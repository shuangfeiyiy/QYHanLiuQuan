//
//  QYNewTableViewCell.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-29.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYNewTableViewCell.h"
#import "QYConstDefine.h"
#import "UIImageView+WebCache.h"

typedef NS_ENUM(int, timeFromNow){
    JUSTNOW = 10,
    SECONDS = 60,
    MINUTES = 60*60,
    HOURS = 60*60*60,
    DAYS = 60*60*60*24
}; 
@interface QYNewTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *newsImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDatetime;
@property (weak, nonatomic) IBOutlet UILabel *labelSource;
@property (weak, nonatomic) IBOutlet UILabel *labelCategory;
@property (weak, nonatomic) IBOutlet UILabel *labelNews;
@end

@implementation QYNewTableViewCell

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
    //初始化标题
    NSUInteger wordsPerLine = floor(CGRectGetWidth(self.labelTitle.frame) / 12.0f);
    if ([self.cellData[kTitle] length] > wordsPerLine) {
        self.labelTitle.text = [self.cellData[kTitle] substringToIndex:wordsPerLine];
        NSUInteger p = 0;
        for (int i = 0;i < [self.labelTitle.text length];i++) {
            NSString *charFromString = [self.labelTitle.text substringWithRange:NSMakeRange(i, 1)];
            NSString *condation =@"^[A-Za-z0-9].*";
            NSPredicate *presicate = [NSPredicate predicateWithFormat:@"self MATCHES %@",condation];
            if ([presicate evaluateWithObject:charFromString]) {
                p++;
            }
        }
        self.labelTitle.text = self.cellData[kTitle];
    }else{
        self.labelTitle.text = self.cellData[kTitle];
    }
    
    [self.newsImageView setImageWithURL:[NSURL URLWithString:self.cellData[kImageUrl]]];
//    //初始化微博的发布时间
    NSString *strDatetime = [[self class] dateSwithWithDate:self.cellData[kDate]];
    self.labelDatetime.text = strDatetime;
    self.labelDatetime.font = [UIFont systemFontOfSize:11.0];
    [self.labelDatetime setTextColor:[UIColor colorWithRed:0.118 green:0.843 blue:0.450 alpha:1.000]];
    //初始化文章来源
    self.labelSource.text = self.cellData[kAuthor];
    self.labelSource.textColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.000];
    
    //初始化文章种类
//    _kindLable.frame = CGRectMake(CGRectGetMaxX(_sourceLable.frame) + 5, _timeLable.frame.origin.y, 0, 10);
    self.labelCategory.text = self.cellData[kTheme];
    self.labelCategory.textColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.000];
    self.labelCategory.font = [UIFont systemFontOfSize:11];
    
    //初始化正文
    self.labelNews.text = self.cellData[kContent];
    NSDictionary *attributs = @{NSFontAttributeName:[UIFont systemFontOfSize:13.0f]};
    CGSize size = [self.labelNews.text sizeWithAttributes:attributs];
    NSUInteger wordsPerLineForText = floor(214.0f / 13.0f);
    CGFloat widthPerLine = 13.0f * wordsPerLineForText;
    NSUInteger nLines = ceil( size.width / widthPerLine );
    self.labelNews.numberOfLines = nLines;
    self.labelNews.textColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.000];
    self.labelNews.font = [UIFont systemFontOfSize:13.0];
    UIEdgeInsetsMake(3.5, 0, 3.5, 0);
}

+ (NSString *)dateSwithWithDate:(NSString *) myDate
{
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc]init];
    [dateFormate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormate setCalendar:[NSCalendar currentCalendar]];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:[dateFormate dateFromString:myDate]];
    NSDate *localeDate = [[dateFormate dateFromString:myDate]  dateByAddingTimeInterval: interval];
    // NSDate *dateFromString = [dateFormate dateFromString:myDate];
    //NSTimeInterval tim = [localeDate timeIntervalSinceNow];
    NSTimeInterval time = abs((int)[localeDate timeIntervalSinceNow]);
    
    NSString *string = nil;
    if (time < JUSTNOW) {
        string = @"刚刚";
    }else if (time < SECONDS){
        string = [NSString stringWithFormat:@"%.f秒前",time];
    }else if (time < MINUTES){
        string = [NSString stringWithFormat:@"%.f分钟前",time/60];
    }else if (time < HOURS){
        string = [NSString stringWithFormat:@"%.f小时前",time/60/60];
    }else{
        string = [NSString stringWithFormat:@"%.f天前",time/60/60/24];
    }
    return string;
}

@end
