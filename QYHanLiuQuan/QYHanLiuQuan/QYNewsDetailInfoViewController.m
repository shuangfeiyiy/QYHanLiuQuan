//
//  QYBBSDetailInfoViewController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-11-3.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYNewsDetailInfoViewController.h"

@interface QYNewsDetailInfoViewController ()

@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation QYNewsDetailInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    self.toolBar = [[UIToolbar alloc] init];
    self.toolBar.frame = CGRectMake(0, 568-44-20, 320, 44);
    [self.view addSubview:self.toolBar];
    [self createToolBarItems];

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
