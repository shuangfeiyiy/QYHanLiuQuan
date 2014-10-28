//
//  QYViewControllerManager.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYViewControllerManager.h"
#import "QYMainTabBarController.h"
#import "QYUserGuideViewController.h"
#import "QYLoginViewController.h"


@implementation QYViewControllerManager


//根据传入不同类型的参数，弹出对应的ViewController
+ (void)presentQYController:(QYViewControllerType)controllerType
{
    UIViewController *controller = [[[self alloc] init] controllerByType:controllerType];
    
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    window.rootViewController = controller;
}

- (UIViewController *)controllerByType:(QYViewControllerType)type
{
    UIViewController *controller = nil;
    
    switch (type) {
        case QYViewControllerTypeUserGuide:
            controller = [self createUserGuideController];
            break;
        case QYViewControllerTypeLogin:
            controller = [self createLoginViewController];
            break;
        case QYViewControllerTypeMainTabBar:
            controller = [self createMainTabBarController];
            break;
            
        default:
            break;
    }

    return controller;
}

- (QYLoginViewController*)createLoginViewController
{
    QYLoginViewController *loginViewController = [[QYLoginViewController alloc] init];
    return loginViewController;
}

- (QYMainTabBarController*)createMainTabBarController
{
    QYMainTabBarController *mainTabBarController = [[QYMainTabBarController alloc] init];
    return mainTabBarController;
}

- (QYUserGuideViewController*)createUserGuideController
{
    QYUserGuideViewController *userGuideViewController = [[QYUserGuideViewController alloc] init];
    return userGuideViewController;
}

@end
