//
//  SMWeiboAction.h
//  GDShareModuleProject
//
//  Created by Apple on 2017/1/3.
//  Copyright © 2017年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMEnum.h"
@class SMActionParam;

@interface SMWeiboAction : NSObject

+ (SMActionResult)sendWeiboActionType:(SMWeiboActionType)actionType param:(SMActionParam *)param accessToken:(NSString *)accessToken;

@end
