//
//  SMShareManagerProtocol.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMEnum.h"

@class SMShareManager;
@class SMOauthUser;

@protocol SMShareManagerProtocol <NSObject>

- (void)shareManagerLoginSuccessWithUserInfomation:(SMOauthUser  *)infomation;

- (void)shareManagerLoginFailWithCancel:(BOOL)cancel;

- (void)shareManagerNetworkFail;

- (void)shareManagerActionResult:(SMActionResult)result;

@end
