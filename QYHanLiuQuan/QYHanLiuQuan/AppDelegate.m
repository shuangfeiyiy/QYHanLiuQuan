//
//  AppDelegate.m
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "QYConstDefine.h"
#import "QYCommonDefine.h"
#import "QYViewControllerManager.h"
#import "WeiboSDK.h"

@interface AppDelegate () <WeiboSDKDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self initLaunchStatus];
    //微博第三方平台登录注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
//    如果是首次登录，则弹出用户指引界面
    if ([NSUD boolForKey:kFirstLaunch]) {
        [QYViewControllerManager presentQYController:QYViewControllerTypeUserGuide];
    }else //如果不是首次登录，根据产品有咨讯功能的特点，则直接进入咨讯界面
    {
       
        [QYViewControllerManager presentQYController:QYViewControllerTypeMainTabBar];
       
    }
    [self.window makeKeyAndVisible];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [WeiboSDK handleOpenURL:url delegate:self];
}

#pragma mark -
#pragma mark WeiboAppDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    if ([request isKindOfClass:WBProvideMessageForWeiboRequest.class])
    {

    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class]){
        
    }else if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        
        if (0 == [(WBAuthorizeResponse *)response userID]) {
            return;
        }else
        {
            [QYNSDC postNotificationName:kQYNotificationNameLogin object:[(WBAuthorizeResponse *)response userID]];
            
        }
    }
}

- (void)initLaunchStatus
{
    if (![NSUD boolForKey:kEverLaunched]) {
        [NSUD setBool:YES forKey:kEverLaunched];
        [NSUD setBool:YES forKey:kFirstLaunch];
    }
    else{
        [NSUD setBool:NO forKey:kFirstLaunch];
    }
    [NSUD synchronize];
}

@end
