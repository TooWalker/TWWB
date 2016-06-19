//
//  UIWindow+Extension.m
//  TWWB
//
//  Created by TooWalker on 1/5/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "TWTabBarViewController.h"
#import "TWNewFeatureViewController.h"

@implementation UIWindow (Extension)
- (void)switchRootViewController{
    
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([lastVersion isEqualToString:currentVersion]) {
        self.rootViewController = [[TWTabBarViewController alloc] init];
    }else{
        self.rootViewController = [[TWNewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
