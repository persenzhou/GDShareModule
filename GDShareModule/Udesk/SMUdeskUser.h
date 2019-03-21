//
//  SMUdeskUser.h
//  ShareModuleProject
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMUdeskUser : NSObject

@property (nonatomic, copy) NSString *sdk_token;//用户唯一标识(user_id)
@property (nonatomic, copy) NSString *nickName;//用户名字
@property (nonatomic, copy) NSString *phoneNum;//用户手机号
@property (nonatomic, copy) NSString *email;//邮箱账号
@property (nonatomic, copy) NSString *desc;//用户描述

@end
