//
//  SMWeChat.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SMShareManagerProtocol.h"
@class SMActionParam;

@interface SMWeChat : NSObject

// 注册
+ (BOOL)registerAppWithAppId:(NSString *)appId;

// Handle Open URL
+ (BOOL)validateOpenUrl:(NSURL *)url;

- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate;

// 授权登录
- (BOOL)authorizeWithOpenId:(NSString *)openId appSecret:(NSString *)appSecret viewController:(UIViewController*)viewController delegate:(id<SMShareManagerProtocol>)delegate;

// 分享
- (void)sendWeChatActionType:(SMWeChatActionType)acitonType platform:(SMPlatformType)platformType param:(SMActionParam *)param;

@end
