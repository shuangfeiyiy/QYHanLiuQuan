//
//  QYNewsViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYNewsViewController.h"
#import "UIButton+ImageWithLabel.h"
#import "AFNetworking.h"
#import "QYCommonDefine.h"
#import "QYNewTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "QYConstDefine.h"
#import "QYNewsDetailInfoViewController.h"


static NSString *QYNewsCellIdentifier = @"NewsCellIdentifier";

@interface QYNewsViewController ()

@property (nonatomic, copy) NSArray *newsList;
@end

@implementation QYNewsViewController
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIImage *toolImage = [UIImage imageNamed:@"主导航-资讯-press"];
        UITabBarItem *newsItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"主导航-资讯"] selectedImage:[toolImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        self.tabBarItem = newsItem;
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 导航栏左边按纽
    UIButton *btnFilter = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    btnFilter.titleLabel.font = [UIFont systemFontOfSize:20.0f];
    [btnFilter setImage:[UIImage imageNamed:@"筛选箭头"] withTitle:@"综合" forState:UIControlStateNormal];
    [btnFilter setImage:[UIImage imageNamed:@"筛选箭头up"] withTitle:@"综合" forState:UIControlStateHighlighted];
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView:btnFilter];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    // 导航栏的Title
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLable.font = [UIFont boldSystemFontOfSize:20.0f];
    titleLable.text = @"韩流圈";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLable;
    
    // 导航栏右边按纽
    UIButton *rightBtn =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightBtn addTarget:self action:@selector(onRightBarItem:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    UIBarButtonItem *rightItem =[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    rightBtn.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // UITableView下拉刷新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开立即刷新"];
    [refreshControl addTarget:self action:@selector(onRefreshControl:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // 焦点图界面实现
    UIView *foucsImgBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 170)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 150)];
    imageView.tag = 1000;
    UILabel *tittleLable = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(imageView.frame), 310, 20)];
    [foucsImgBackgroundView addSubview:imageView];
    [foucsImgBackgroundView addSubview:tittleLable];
    self.tableView.tableHeaderView = foucsImgBackgroundView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"QYNewTableViewCell" bundle:nil] forCellReuseIdentifier:QYNewsCellIdentifier];
}

- (void)onRefreshControl:(UIRefreshControl*)refreshControl
{
    NSLog(@"%s",__func__);
    [self requestNewsDataFromServer];
}

- (void)onRightBarItem:(UIBarButtonItem*)sender
{
    
}

//通过网络从服务器上请求咨讯列表的数据
-(void)requestNewsDataFromServer
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"theme": @"综合", @"max_id":@"39", @"refresh":@"0"};
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager POST:HLQ_STR_URL_NEWS_LIST
       parameters:parameters
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [self.refreshControl endRefreshing];
              if ([[responseObject objectForKey:@"success"] doubleValue]) {
                  NSLog(@"result :%@",operation.responseString);
                  self.newsList = [responseObject objectForKey:@"data"];
                  UIImageView *imgView = (UIImageView*)[self.tableView.tableHeaderView viewWithTag:1000];
                  [imgView setImageWithURL:self.newsList[0][kImageUrl]];
                  [self.tableView reloadData];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [self.refreshControl endRefreshing];
              
          }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.newsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QYNewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:QYNewsCellIdentifier forIndexPath:indexPath];
    cell.cellData = self.newsList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 124;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    QYNewsDetailInfoViewController *detailInfoViewController = [[QYNewsDetailInfoViewController alloc] initWithStyle:UITableViewStyleGrouped];
    detailInfoViewController.hidesBottomBarWhenPushed = YES;
    detailInfoViewController.newsDetailInfo = self.newsList[indexPath.row];
    [self.navigationController pushViewController:detailInfoViewController animated:YES];
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    ; *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/
@end
