//
//  SMOauthUser.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMOauthUser : NSObject
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *accessToken;

+ (instancetype)oauthUserWithNickName:(NSString *)nickName iconUrl:(NSString *)iconUrl userId:(NSString *)userId accessToken:(NSString *)accessToken;

@end
