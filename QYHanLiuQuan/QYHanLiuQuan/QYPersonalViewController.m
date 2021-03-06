//
//  QYPersonalViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYPersonalViewController.h"
#import "QYNavigationController.h"
#import "QYLoginViewController.h"
#import "QYCommonDefine.h"
#import "QYConstDefine.h"

@interface QYPersonalViewController ()

@end

@implementation QYPersonalViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        UIImage *bbsImage = [UIImage imageNamed:@"主导航-个人页-press"];
        UITabBarItem *bbsItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"主导航-个人页"] selectedImage:[bbsImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        self.tabBarItem = bbsItem;
        [self.tabBarItem setImageInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *modifyPersonalInfoItem =  [[UIBarButtonItem alloc] initWithTitle:@"修改" style:UIBarButtonItemStyleDone target:self action:@selector(onModifyBarItem:)];
    modifyPersonalInfoItem.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = modifyPersonalInfoItem;
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 40)];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.text = @"个人信息";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = titleLabel;
    
    //导航栏右btn
    UIButton *btnSetting =[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [btnSetting setImage:[UIImage imageNamed:@"设置"] forState:UIControlStateNormal];
    [btnSetting setImage:[UIImage imageNamed:@"设置-press"] forState:UIControlStateHighlighted];
    [btnSetting addTarget:self action:@selector(onSettingBarBtnItem:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtnItem =[[UIBarButtonItem alloc]initWithCustomView:btnSetting];
    self.navigationItem.rightBarButtonItem = barBtnItem;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![NSUD boolForKey:kIsAuthorOK]) {
        QYLoginViewController *loginViewController = [[QYLoginViewController alloc] init];
        loginViewController.isTabBarRootViewController = YES;
        [self.navigationController pushViewController:loginViewController animated:YES];
    }
    
}
- (void)onSettingBarBtnItem:(UIBarButtonItem*)barBtnItem
{
    
}

- (void)onModifyBarItem:(UIBarButtonItem*)barBtnItem
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
