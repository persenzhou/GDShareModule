//
//  SMTencent.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMShareManagerProtocol.h"

@class SMActionParam;

@interface SMTencent : NSObject

// Handle Open URL
+ (BOOL)validateOpenUrl:(NSURL *)url;
- (BOOL)handleOpenURL:(NSURL *)url delegate:(id <SMShareManagerProtocol>)delegate;

// Register 不一定在 application 中 注册！
- (BOOL)registerQQWithAppId:(NSString *)appId delegate:(id <SMShareManagerProtocol>)delegate;

// 授权登录
- (BOOL)authorize;

//分享、咨询
- (void)sendTencentActionWithType:(SMTencentActionType)acitonType param:(SMActionParam *)param;

@end
