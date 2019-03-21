//
//  SMShareView.h
//  ShareModuleProject
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 SM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMEnum.h"

@class SMActionParam;

@interface SMShareView : UIView

+ (instancetype)shareViewWithShareType:(SMShareType)shareType shareParam:(SMActionParam *)parma;

- (void)show;
- (void)dismiss;

@end
