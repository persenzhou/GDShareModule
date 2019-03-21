//
//  SMUdesk.h
//  ShareModuleProject
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class SMUdeskUser;
@class SMUdeskStyle;
@interface SMUdesk : NSObject
/*
    Register
 
    domain  公司注册的Udesk域名
 */
+ (void)registerWithAppKey:(NSString *)appKey appId:(NSString *)appId domain:(NSString *)domain;

+ (void)configUser:(SMUdeskUser *)userInfo;

+ (void)pushChatWithViewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style completion:(void (^)(void))completion;

+ (void)presentChatWithViewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style completion:(void (^)(void))completion;

@end
