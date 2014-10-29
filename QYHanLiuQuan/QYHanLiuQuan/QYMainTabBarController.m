//
//  QYMainTabBarController.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYMainTabBarController.h"
#import "QYNavigationController.h"
#import "QYNewsViewController.h"
#import "QYBBSViewController.h"
#import "QYPersonalViewController.h"

@interface QYMainTabBarController ()

@end

@implementation QYMainTabBarController

- (id)init
{
    self = [super init];
    if (self) {
//        [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar_background"]];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    咨询界面
    QYNewsViewController *newsViewController = [[QYNewsViewController alloc] initWithStyle:UITableViewStylePlain];
//    BBS界面
    QYBBSViewController *bbsViewController = [[QYBBSViewController alloc] initWithStyle:UITableViewStylePlain];
//    个人信息界面
    QYPersonalViewController *personalViewController = [[QYPersonalViewController alloc] initWithStyle:UITableViewStylePlain];
//    由于对于UITabBarController，每一个主界面需要继续导航， 所以放到数组里后续创建导航控制器
    NSArray *viewControllers = @[newsViewController,bbsViewController,personalViewController];
    
    NSMutableArray *viewNavControlles = [[NSMutableArray alloc] initWithCapacity:3];
    for (UIViewController *vctrlItem in viewControllers) {
        QYNavigationController  *nav = [[QYNavigationController alloc] initWithRootViewController:vctrlItem];
        [viewNavControlles addObject:nav];
    }
    self.viewControllers = viewNavControlles;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
