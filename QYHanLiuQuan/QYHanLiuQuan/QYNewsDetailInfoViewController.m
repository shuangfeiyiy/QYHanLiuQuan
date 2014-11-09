//
//  QYBBSDetailInfoViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-11-3.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYNewsDetailInfoViewController.h"
#import "UIImageView+WebCache.h"
#import "QYConstDefine.h"
#import "NSString+FrameHeight.h"

static NSString *kCellIndentifier = @"QYNewsDetailInfoViewCell";

@interface QYNewsDetailInfoViewController ()
//详细咨询信息界面，头部信息
@property (weak, nonatomic) IBOutlet UIView *tableHeaderBgView;
@property (weak, nonatomic) IBOutlet UIImageView *tableHeaderImageView;
@property (weak, nonatomic) IBOutlet UIPageControl *tableHeaderPageControl;
@property (weak, nonatomic) IBOutlet UILabel *tableHeaderLabelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDateTime;
@property (weak, nonatomic) IBOutlet UILabel *labelSource;
@property (weak, nonatomic) IBOutlet UILabel *labelTheme;

@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation QYNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    //详细咨询信息焦点图
    [self.tableHeaderImageView setImageWithURL:[NSURL URLWithString:self.newsDetailInfo[kImageUrl]]];
    
    //详细咨询信息标题
    self.tableHeaderLabelTitle.text = self.newsDetailInfo[kTitle];
    
    //咨询信息、日期 只显示月份和日期
    NSString *strDateTime = self.newsDetailInfo[kDate];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setCalendar:[NSCalendar currentCalendar]];
    NSDate *dateFromString = [dateFormatter dateFromString:strDateTime];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSSecondCalendarUnit | NSMinuteCalendarUnit | NSHourCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:dateFromString];
    self.labelDateTime.text = [NSString stringWithFormat:@"%ld.%ld",(long)components.month,(long)components.day];
    
    //咨询来源
    NSString *strSource = [self.newsDetailInfo objectForKey:kAuthor];
    self.labelSource.text = strSource;
    
    //所属主题
    NSString *strTheme = self.newsDetailInfo[kTheme];
    self.labelTheme.text = strTheme;
    
    //界面底部的UIToolBar
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.frame = CGRectMake(0, 568-44, 320, 44);
    [[UIApplication sharedApplication].keyWindow addSubview:self.toolBar];
    [self createToolBarItems];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIndentifier];

}

- (void)createToolBarItems
{
    //空格，为了布局UIToolBar上的元素需要
    UIBarButtonItem *btnItemFlexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //工具条上的返回按纽
    UIImage *backBtnImg = [UIImage imageNamed:@"内页-返回"];
    backBtnImg = [backBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btnItemBack = [[UIBarButtonItem alloc]initWithImage:backBtnImg style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonItemBack:)];
    
    //工具条上的收藏按纽
    UIButton *btnCollection = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCollection.frame = CGRectMake(0, 0, 30, 30);
    [btnCollection addTarget:self action:@selector(onBarButtonCollection:) forControlEvents:UIControlEventTouchUpInside];
    [btnCollection setImage:[UIImage imageNamed:@"内页-收藏"] forState:UIControlStateNormal];
    [btnCollection setImage:[UIImage imageNamed:@"内页-收藏-press"] forState:UIControlStateSelected];
    btnCollection.tag = 10;
    UIBarButtonItem *btnItemCollection = [[UIBarButtonItem alloc]initWithCustomView:btnCollection];
    
    //工具条上的回复按纽
    UIImage *commentBtnImg = [UIImage imageNamed:@"内页-评论"];
    commentBtnImg = [commentBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btnItemComment = [[UIBarButtonItem alloc]initWithImage:commentBtnImg style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonComment:)];
    
    //工具条上的分享按纽
    UIImage *shareBtnImg = [UIImage imageNamed:@"内页-分享"];
    shareBtnImg = [shareBtnImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *btnItemShare = [[UIBarButtonItem alloc]initWithImage:shareBtnImg style:UIBarButtonItemStylePlain target:self action:@selector(onBarButtonShare:)];
    
    [self.toolBar setItems:@[btnItemBack,btnItemFlexibleSpace,btnItemCollection,btnItemFlexibleSpace,btnItemComment,btnItemFlexibleSpace,btnItemShare]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.toolBar removeFromSuperview];
}

#pragma mark -
#pragma mark 工具条上的UIBarButtonItem点击的时候的回调方法
//工具条上返回按纽回调方法
- (void)onBarButtonItemBack:(UIBarButtonItem*)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//工具条上收藏按纽回调方法
- (void)onBarButtonCollection:(UIButton*)sender
{
    
}

//工具条上回复评论按纽的回调方法
- (void)onBarButtonComment:(UIBarButtonItem*)sender
{
    
}

//工具条上分享按纽的回调方法
- (void)onBarButtonShare:(UIBarButtonItem*)sender
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier forIndexPath:indexPath];
    cell.textLabel.text = self.newsDetailInfo[kContent];
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    cell.textLabel.numberOfLines = 0;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellText = self.newsDetailInfo[kContent];
//    从服务器上取下来的文章内容带有换行和回车， 所以去掉\n\r之后再计算文本的高度，否则计算的值不准确
    NSString *cellTextWithoutReturn = [cellText stringByReplacingOccurrencesOfString:@"\n\r" withString:@""];
    CGFloat heightOfCellText = [cellTextWithoutReturn frameHeightWithFontSize:14.0f forViewWidth:tableView.bounds.size.height];
    return heightOfCellText;
}

@end
