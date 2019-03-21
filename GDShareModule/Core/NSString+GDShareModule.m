//
//  NSString+SMShareModule.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "NSString+GDShareModule.h"

@implementation NSString (GDShareModule)

- (BOOL)sm_emptyString
{
    BOOL empry = !self || self.length == 0 || [self isKindOfClass:[NSNull class]];
    return empry;
}


- (NSString *)utf8String
{
     return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)self, NULL, NULL,  kCFStringEncodingUTF8 ));
}

@end
