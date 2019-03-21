//
//  SMShareManager.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SMShareManagerProtocol.h"

@class SMActionParam;

@interface SMShareManager : NSObject

+ (instancetype)shareManager;
// 清理功能（清理之后需要重新注册）
+ (void)clearUp;

// 注册
+ (BOOL)registerQQWithAppId:(NSString *)appId delegate:(id <SMShareManagerProtocol>)delegate;
+ (BOOL)registerWeiboWithAppId:(NSString *)appId;
+ (BOOL)registerWeChatWithAppId:(NSString *)appId;

// Application 回调
+ (SMPlatformType)validateOpenUrl:(NSURL *)url;
+ (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate shareType:(SMPlatformType)shareType;

// 登录
+ (void)qqLogin;
+ (void)weiboLoginWithRedirectURI:(NSString *)redirectURI;
+ (void)wechatLoginWithOpenId:(NSString *)openId appSecret:(NSString *)appSecret viewController:(UIViewController*)viewController delegate:(id<SMShareManagerProtocol>)delegate;

// 分享
+ (void)shareWithPlatformType:(SMPlatformType)platformType shareType:(SMShareType)shareType param:(SMActionParam *)param;

+ (void)showShareViewWithShareType:(SMShareType)shareType shareParam:(SMActionParam *)param;
@end
