//
//  AppDelegate.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "AppDelegate.h"
#import "TWTabBarViewController.h"
#import "TWNewFeatureViewController.h"
#import "TWOAuthViewController.h"
#import "TWAccountTool.h"
#import "TWOAuthViewController.h"
#import "UIWindow+Extension.h"
#import "SDWebImageManager.h"

#define IS_IOS8 ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0)

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    if (IS_IOS8) {
//        UIUserNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        UIUserNotificationSettings *mySetting = [UIUserNotificationSettings settingsForTypes:myType categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:mySetting];
//    }else{
//        UIRemoteNotificationType myType = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myType];
//    }
    
    
    if (IS_IOS8) {
        
        UIUserNotificationSettings
        *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        
        [[UIApplication
          sharedApplication] registerUserNotificationSettings:settings];
    }

    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    TWAccount *account = [TWAccountTool account];
    if (account) {
        [self.window switchRootViewController];
    }else{
        self.window.rootViewController = [[TWOAuthViewController alloc] init];
    }

    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    __block UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *mgr = [[SDWebImageManager alloc] init];
    [mgr cancelAll];
    [mgr.imageCache clearMemory];
}

@end
