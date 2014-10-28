//
//  QYViewControllerManager.h
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, QYViewControllerType) {
    QYViewControllerTypeUserGuide,
    QYViewControllerTypeLogin,
    QYViewControllerTypeMainTabBar
};

@interface QYViewControllerManager : NSObject

+ (void)presentQYController:(QYViewControllerType)controllerType;
@end
