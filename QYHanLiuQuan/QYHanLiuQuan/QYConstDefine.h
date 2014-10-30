//
//  QYConstDefine.h
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#ifndef QYHanLiuQuan_QYConstDefine_h
#define QYHanLiuQuan_QYConstDefine_h

/*
 * 关于通知中心自定义通知名字常量定义区
 */
static NSString * const kQYNotificationNameLogin = @"LoginNotification";
static NSString * const kQYNotificationNameLogoff = @"LogoffNotification";

/*
 *在首选项目里设置是否首次登录标志位
 */
static NSString * const kEverLaunched = @"EverLaunched";
static NSString * const kFirstLaunch = @"FirstLaunch";

/*
 * 咨询界面从服务器获取数据，对应的数据Key,此部份内容需要与服务器保持一致
 */
static NSString * const kData = @"data";
static NSString * const kSuccess = @"success";
static NSString * const kAuthor = @"author";
static NSString * const kImageUrl = @"image";
static NSString * const kContent = @"content";
static NSString * const kTheme = @"theme";
static NSString * const kDate = @"date";
static NSString * const kID = @"id";
static NSString * const kTitle = @"titile";

/*
 *评论数据与服务器对应的数据key,此部份内容需要与服务器数据保持一致
 */
static NSString * const kContentText = @"content_text";
static NSString * const kAvatarImg = @"avatar_img";
static NSString * const kUserId = @"usr_id";
static NSString * const kFloorNum = @"floor_num";
static NSString * const kUserName = @"usr_name";
static NSString * const kAttitude_count = @"attitude_count";
static NSString * const kIsCollect = @"iscollect";

/*
 * 个人数据与服务器对应的数据key，此部份内容需要与服务器数据保持一致
 */
static NSString * const kUserID = @"user_id";
#endif
