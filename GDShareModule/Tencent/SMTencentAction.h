//
//  SMTencentAction.h
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/29.
//  Copyright © 2016年 SM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMEnum.h"

@class SMActionParam;


@interface SMTencentAction : NSObject

+ (SMActionResult)sendTencentActionWithType:(SMTencentActionType)acitonType param:(SMActionParam *)param;


@end
