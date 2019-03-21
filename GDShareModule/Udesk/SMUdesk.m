//
//  SMUdesk.m
//  ShareModuleProject
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "SMUdesk.h"
#import "Udesk.h"
#import "SMUdeskUser.h"
#import "SMUdeskStyle.h"

@implementation SMUdesk

+ (void)registerWithAppKey:(NSString *)appKey appId:(NSString *)appId domain:(NSString *)domain
{
    [UdeskManager initWithAppKey:appKey appId:appId domain:domain];
}

+ (void)configUser:(SMUdeskUser *)userInfo
{
    NSDictionary *parameters = @{
                                 @"user": @{
                                         @"nick_name": userInfo.nickName,
                                         @"cellphone":userInfo.phoneNum,
                                         @"email":userInfo.email,
                                         @"description":userInfo.desc,
                                         @"sdk_token":userInfo.sdk_token
                                         }
                                 };
    
    [UdeskManager createCustomerWithCustomerInfo:parameters];
}


+ (void)pushChatWithViewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style completion:(void (^)(void))completion
{
    UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:style];
    
    [chat pushUdeskViewControllerWithType:UdeskIM viewController:viewController completion:completion];
    
}

+ (void)presentChatWithViewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style completion:(void (^)(void))completion
{
    UdeskSDKManager *chat = [[UdeskSDKManager alloc] initWithSDKStyle:style];
    
    [chat presentUdeskViewControllerWithType:UdeskIM viewController:viewController completion:completion];
}

@end
