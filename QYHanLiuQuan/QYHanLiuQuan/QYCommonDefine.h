//
//  QYCommonDefine.h
//  QYHanLiuQuan
//
//  Created by QingYun on 14-10-28.
//  Copyright (c) 2014年 河南青云信息技术有限公司. All rights reserved.
//

#ifndef QYHanLiuQuan_QYCommonDefine_h
#define QYHanLiuQuan_QYCommonDefine_h

#define   NSUD           [NSUserDefaults standardUserDefaults]
#define   QYNSDC         [NSNotificationCenter defaultCenter]

#define   appDelegate    ((QYAppDelegate*)([UIApplication sharedApplication].delegate))

//第三方登录平台
//新浪注册所需要信息的常量定义
//如果需要测试此工程，需要修改此处的应用信息为自己的信息
#define kAppKey @"1151675697"
#define kAppSecret @"ba089ae1cab9fb771478b1b19ab815f2"
#define kAppRedirectURI @"https://api.weibo.com/oauth2/default.html"

//关于韩流圈从服务器上获取数据定义的URL
#define  BASE_URL           @"http://1.hallyu.sinaapp.com"

//登录
#define  HLQ_STR_URL_LOGIN             [BASE_URL stringByAppendingString:@"/hlq_api/login/"]
#define  HLQ_STR_URL_WEIBO_LOGIN       [BASE_URL stringByAppendingString:@"/hlq_api/weibo_login/"]

//资讯
#define  HLQ_STR_URL_NEWS_LIST         [BASE_URL stringByAppendingString:@"/hlq_api/news/"]
#define  HLQ_STR_URL_NEWS_ADDCOMMENTS  [BASE_URL stringByAppendingString:@"/hlq_api/addcomment/"]
#define  HLQ_STR_URL_NEWS_COMMENTS     [BASE_URL stringByAppendingString:@"/hlq_api/comment/"]
#define  HLQ_STR_URL_NEWS_COLLECT      [BASE_URL stringByAppendingString:@"/hlq_api/collect/"]
#define  HLQ_STR_URL_NEWS_GETCOLLECT   [BASE_URL stringByAppendingString:@"/hlq_api/getcollect/"]

//BBS
#define  HLQ_STR_URL_BBS_LIST [BASE_URL stringByAppendingString:@"/hlq_api/thread/"]
#define  HLQ_STR_URL_BBS_COMMENT_URL     [BASE_URL stringByAppendingString:@"/hlq_api/posts/"]
#define  HLQ_STR_URL_BBS_WRITE           [BASE_URL stringByAppendingString:@"/hlq_api/addthread/"]
#define  HLQ_STR_URL_BBS_ADDANSWER_URL   [BASE_URL stringByAppendingString:@"/hlq_api/addpost/"]
#define  HLQ_STR_URL_BBS_COLLECT_URL     [BASE_URL stringByAppendingString:@"/hlq_api/collect/"]
#define  HLQ_STR_URL_BBS_ZAN_URL         [BASE_URL stringByAppendingString:@"/hlq_api/favor/"]
#define  HLQ_STR_URL_COMMENT_LIST        [BASE_URL stringByAppendingString:@"/hlq_api/comment/"]

//个人信息
#define  HLQ_STR_URL_PERSON_PROFILE               [BASE_URL stringByAppendingString:@"/hlq_api/profile/"]
#define  HLQ_STR_URL_PERSON_SEND                  [BASE_URL stringByAppendingString:@"/hlq_api/send_message/"]
#define  HLQ_STR_URL_PERSON_GET                   [BASE_URL stringByAppendingString:@"/hlq_api/get_message/"]
#define  HLQ_STR_URL_PERSON_DEL                   [BASE_URL stringByAppendingString:@"/hlq_api/del_message/"]
#define  HLQ_STR_URL_PERSON_FANSANDATTENTION_LIST [BASE_URL stringByAppendingString:@"/hlq_api/follower/"]
#define  HLQ_STR_URL_PERSON_ADD_FANS              [BASE_URL stringByAppendingString:@"/hlq_api/add_fans/"]
#define  HLQ_STR_URL_PERSON_READ_MESSAGE          [BASE_URL stringByAppendingString:@"/hlq_api/read_message/"]


#endif
