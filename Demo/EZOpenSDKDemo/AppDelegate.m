//
//  AppDelegate.m
//  EZOpenSDKDemo
//
//  Created by DeJohn Dong on 15/10/27.
//  Copyright © 2015年 hikvision. All rights reserved.
//

#import "AppDelegate.h"

#define EzvizAppKey @"934c85e8e2664e8eb1db401bd82fceef"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册APNS
    [self registerAPNS];
    
#ifdef EZVIZ_GLOBAL_DEMO
    [EZOPENSDK initLibWithAppKey:EzvizAppKey url:nil authUrl:nil];
#else
    [EZOPENSDK initLibWithAppKey:EzvizAppKey];
#endif
    
    [EZOPENSDK enableP2P:YES];
    
    [EZOPENSDK setDebugLogEnable:YES];
    
    NSLog(@"EZOpenSDK Version = %@", [EZOPENSDK getVersion]);
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    NSLog(@"applicationWillResignActive");
    sleep(0.5);
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
//        // Clean up any unfinished task business by marking where you
//        // stopped or ending the task outright.
//        [application endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    }];
    
    // Start the long-running task and return immediately.
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        // Do the work associated with the task, preferably in chunks.
//        [NSThread sleepForTimeInterval:60];
//        
//        //告诉系统我们完成了
//        [application endBackgroundTask:bgTask];
//        bgTask = UIBackgroundTaskInvalid;
//    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"applicationWillEnterForeground");
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"applicationDidBecomeActive");
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"applicationWillTerminate");
}

- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSLog(@"注册APNS TOKEN成功：%@,%lu",deviceToken,(unsigned long)deviceToken.length);
    
    NSString *newToken = [NSString stringWithFormat:@"%@",deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"注册失败，无法获取设备ID: %@",err);
}

//获取远程通知消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {

}

- (void)registerAPNS
{
    NSLog(@"Registering for push notifications...");
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
    }
}

@end
