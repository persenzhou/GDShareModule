//
//  AppDelegate.m
//  GDShareModuleProject
//
//  Created by Apple on 2016/12/28.
//  Copyright © 2016年 SM. All rights reserved.
//

#import "AppDelegate.h"
#import "SMShareManager.h"
#import "TableViewController.h"
#import "SMCounseler.h"

#define kWeiXinAppKey @"wx8baf1de2a92d60c4"

#define kSinaAppKey @"1108795777"

#define kUdeskId @"087bfdb9e2170591c8d96c9f4ee1aa69"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SMShareManager registerWeChatWithAppId:kWeiXinAppKey];
    [SMShareManager registerWeiboWithAppId:kSinaAppKey];
    [SMCounseler registerUdeskWithAppKey:kUdeskId appId:nil domain:@"gaodun.udesk.cn"];
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    SMPlatformType type = [SMShareManager validateOpenUrl:url];
    if (type != SMPlatformTypeUnknow)
    {
        UINavigationController *vc = (UINavigationController *)application.keyWindow.rootViewController;
        TableViewController *tableViewController = (TableViewController *)[vc.childViewControllers lastObject];
        return [SMShareManager handleOpenURL:url delegate:tableViewController shareType:type];
    }
    
    return YES;
    
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    SMPlatformType type = [SMShareManager validateOpenUrl:url];
    if (type != SMPlatformTypeUnknow)
    {
        UINavigationController *vc = (UINavigationController *)application.keyWindow.rootViewController;
        TableViewController *tableViewController = (TableViewController *)[vc.childViewControllers lastObject];
        return [SMShareManager handleOpenURL:url delegate:tableViewController shareType:type];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    SMPlatformType type = [SMShareManager validateOpenUrl:url];
    if (type != SMPlatformTypeUnknow)
    {
        UINavigationController *vc = (UINavigationController *)app.keyWindow.rootViewController;
        TableViewController *tableViewController = (TableViewController *)[vc.childViewControllers lastObject];
        return [SMShareManager handleOpenURL:url delegate:tableViewController shareType:type];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
