//
//  SMCounseler.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SMEnum.h"
@class SMUdeskUser;
@class SMUdeskStyle;

typedef NS_ENUM(NSInteger, SMUdeskOpenType){
    SMUdeskOpenTypePush,
    SMUdeskOpenTypePresent
};

@interface SMCounseler : NSObject

/*
  QQ 咨询
 */
+ (SMActionResult)counselWithQQServise:(NSString *)qqServise;


/*
  Udesk 咨询
 */
+ (void)registerUdeskWithAppKey:(NSString *)appKey appId:(NSString *)appId domain:(NSString *)domain;

+ (void)configUser:(SMUdeskUser *)userInfo;

+ (void)counselUdskWithOpenType:(SMUdeskOpenType)type viewController:(UIViewController *)viewController uiStyle:(SMUdeskStyle *)style  completion:(void (^)(void))completion;

@end
