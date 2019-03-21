//
//  NSBundle+SMShareManage.m
//  ShareModuleProject
//
//  Created by Apple on 2017/1/4.
//  Copyright © 2017年 SM. All rights reserved.
//

#import "NSBundle+GDShareModule.h"

@implementation NSBundle (GDShareModule)
+ (instancetype)sm_shareManagerBundle
{
    NSString *bundlePath = [[NSBundle bundleForClass:NSClassFromString(@"SMShareManager")] pathForResource:@"SMShareManager" ofType:@"bundle"];
    
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    return bundle;
}
@end
