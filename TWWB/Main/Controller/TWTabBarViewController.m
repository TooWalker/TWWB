
//
//  TWTabBarViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWTabBarViewController.h"

#import "TWNavigationViewController.h"

#import "TWHomeTableViewController.h"
#import "TWMessageTableViewController.h"
#import "TWDiscoveryTableViewController.h"
#import "TWProfileTableViewController.h"

#import "TWTabBar.h"

@interface TWTabBarViewController () <TWTabBarDelegate>

@end

@implementation TWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TWHomeTableViewController *homeController = [[TWHomeTableViewController alloc] init];
    [self addChildViewController:homeController title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];

    TWMessageTableViewController *messageController = [[TWMessageTableViewController alloc] init];
    [self addChildViewController:messageController title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    TWDiscoveryTableViewController *discoveryController = [[TWDiscoveryTableViewController alloc] init];
    [self addChildViewController:discoveryController title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    TWProfileTableViewController *profileController = [[TWProfileTableViewController alloc] init];
    [self addChildViewController:profileController title:@"我" image:@"tabbar_profile"selectedImage:@"tabbar_profile_selected"];
    
    TWTabBar *tabBar = [[TWTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    childController.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childController.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    TWNavigationViewController *navigationController = [[TWNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:navigationController];
}

- (void)didClickComposeButton:(TWTabBar *)tabBar{
    UIViewController *composeController = [[UIViewController alloc] init];
    composeController.view.backgroundColor = [UIColor redColor];
    [self presentViewController:composeController animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
