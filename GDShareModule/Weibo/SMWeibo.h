//
//  SMWeibo.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SMShareManagerProtocol.h"

@class SMActionParam;

@interface SMWeibo : NSObject

// Handle Open URL
+ (BOOL)validateOpenUrl:(NSURL *)url;
- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate;

// 注册
+ (BOOL)registerAppWithAppId:(NSString *)appId;

// 授权登录
- (BOOL)authorizeWithRedirectURI:(NSString *)redirectURI;

// 分享
- (void)sendWeChatActionType:(SMWeiboActionType)acitonType param:(SMActionParam *)param;

@end
