//
//  QYBBSViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYBBSViewController.h"
#import "QYAutoScrollFocusView.h"
#import "AFNetworking.h"
#import "QYCommonDefine.h"
#import "QYHotBBSTableViewCell.h"
#import "QYNormalBBSTableViewCell.h"

static NSString *normalBBSCellIndentifier = @"QYNormalBBSTableViewCell";
static NSString *hotBBSCellIndectifier = @"QYHotBBSTableViewCell";

@interface QYBBSViewController ()<QYAutoScrollFocusViewDelegate>

@property (nonatomic, strong) QYAutoScrollFocusView *autoScrollFocusView;

@property (nonatomic, strong) NSArray *hotBBSContentList;
@property (nonatomic, strong) NSArray *normalBBSContentList;
@end

@implementation QYBBSViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIImage *bbsImage = [UIImage imageNamed:@"主导航-论坛-press"];
        UITabBarItem *bbsItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"主导航-论坛"] selectedImage:[bbsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        self.tabBarItem = bbsItem;
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏左边按纽
    UIBarButtonItem *witeBBSItem =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(onWriteBBSItem:)];
    witeBBSItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = witeBBSItem;
    
    //导航栏title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"韩流圈";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //导航栏右btn
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"搜索"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(onSearchBarItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem  = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // UITableView下拉刷新
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开立即刷新"];
    [refreshControl addTarget:self action:@selector(onRefreshControl:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
//    //实现焦点图
//    NSMutableArray *imageArray  = [NSMutableArray arrayWithCapacity:5];
//    for (int i = 1; i < 4; i++) {
//        UIImage *focusImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]];
//        [imageArray addObject:focusImage];
//    }
//    self.autoScrollFocusView = [[QYAutoScrollFocusView alloc]initWithFrame:CGRectMake(0, 0, 320, 170) withImageArray:imageArray andStepTime:1.5];
//    NSArray *focusTitleArr = @[@"#0你喜欢长腿欧巴嘛#",@"#1你喜欢长腿欧巴嘛#",@"#2你喜欢长腿欧巴嘛#",@"#3你喜欢长腿欧巴嘛#",@"#4你喜欢长腿欧巴嘛#"];
//    self.autoScrollFocusView.focusTitleArr = focusTitleArr;
//    self.autoScrollFocusView.delegate = self;
//    [self.tableView.tableHeaderView addSubview:self.autoScrollFocusView];


    [self.tableView registerNib:[UINib nibWithNibName:@"QYNormalBBSTableViewCell" bundle:nil] forCellReuseIdentifier:normalBBSCellIndentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"QYHotBBSTableViewCell" bundle:nil] forCellReuseIdentifier:hotBBSCellIndectifier];
}


//根据与服务器制订的接口， 从服务器获取热门贴子的数据
- (void)requestBBSContentFromServer
{
    AFHTTPRequestOperationManager *hotManager = [AFHTTPRequestOperationManager manager];
    NSDictionary *hotParameters = @{@"max_id":@"0", @"refresh":@"1", @"refresh_hot":@"1"};
    hotManager.requestSerializer = [AFJSONRequestSerializer serializer];
    hotManager.responseSerializer = [AFJSONResponseSerializer serializer];
    [hotManager POST:HLQ_STR_URL_BBS_LIST parameters:hotParameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"****下拉刷新**** JSON: %@", responseObject);
        if ([[responseObject objectForKey:@"success"] doubleValue]) {
            self.normalBBSContentList = responseObject[@"data"];
            //此处使用谓词，按日期先后过滤出最新的三条数据，做为最热门的数据
            [self.refreshControl endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"****下拉刷新**** Error: %@", error);
        [self.refreshControl endRefreshing];
    }];

}

- (void)onRefreshControl:(UIRefreshControl*)refreshControl
{
    [self requestBBSContentFromServer];
}

- (void)onWriteBBSItem:(UIBarButtonItem*)barButtonItem
{
    
}

- (void)onSearchBarItem:(UIBarButtonItem*)searchBarButtonItem
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger nSectionCount = 0;
    if (section == 0) {
        nSectionCount = self.hotBBSContentList.count;
    }
    else
    {
        nSectionCount = self.normalBBSContentList.count;
    }
    return nSectionCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:hotBBSCellIndectifier forIndexPath:indexPath];
            ((QYHotBBSTableViewCell*)cell).cellData = self.hotBBSContentList[indexPath.row];
            break;
            case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:normalBBSCellIndentifier forIndexPath:indexPath];
            ((QYNormalBBSTableViewCell*)cell).cellData = self.normalBBSContentList[indexPath.row];
            break;
        default:
            break;
    }
    return cell;
}

@end
