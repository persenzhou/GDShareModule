//
//  SMCounseler.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMCounseler.h"

#import "SMTencentAction.h"

#import "SMActionParam.h"

#import "SMUdesk.h"
@implementation SMCounseler

+ (SMActionResult)counselWithQQServise:(NSString *)qqServise
{
    SMActionParam *param = [[SMActionParam alloc] init];
    param.serviceQQ = qqServise;
    return  [SMTencentAction sendTencentActionWithType:SMTencentActionTypeWPA param:param];
}

/**
 *  初始化Udesk，必须调用此函数，请正确填写参数。
 *
 *  @param appKey    应用key
 *  @param appId  应用ID
 *  @param domain 公司域名
 */
+ (void)registerUdeskWithAppKey:(NSString *)appKey appId:(NSString *)appId domain:(NSString *)domain;
{
    [SMUdesk registerWithAppKey:appKey appId:appId domain:domain];
}

+ (void)configUser:(SMUdeskUser *)userInfo;
{
    [SMUdesk configUser:userInfo];
}

+ (void)counselUdskWithOpenType:(SMUdeskOpenType)type viewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style  completion:(void (^)(void))completion;
{
    switch (type) {
        case SMUdeskOpenTypePush:
            [SMUdesk pushChatWithViewController:viewController uiStyle:style completion:completion];
            break;
        case SMUdeskOpenTypePresent:
            [SMUdesk presentChatWithViewController:viewController uiStyle:style completion:completion];
            break;
    }
}
@end
