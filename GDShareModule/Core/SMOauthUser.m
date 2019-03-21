//
//  SMOauthUser.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "SMOauthUser.h"

@implementation SMOauthUser

+ (instancetype)oauthUserWithNickName:(NSString *)nickName iconUrl:(NSString *)iconUrl userId:(NSString *)userId accessToken:(NSString *)accessToken
{
    SMOauthUser *user = [[SMOauthUser alloc] init];
    user.nickName = nickName;
    user.iconUrl = iconUrl;
    user.userId = userId;
    user.accessToken = accessToken;
    
    return user;
}

@end
