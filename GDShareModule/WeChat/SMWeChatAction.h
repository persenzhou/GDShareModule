//
//  SMWeChatAction.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/30.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMEnum.h"
@class SMActionParam;

@interface SMWeChatAction : NSObject
+ (SMActionResult)sendWeChatActionType:(SMWeChatActionType)acitonType platform:(SMPlatformType)platformType param:(SMActionParam *)param;
@end
