//
//  TWNavigationViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWNavigationViewController.h"

@interface TWNavigationViewController ()

@end

@implementation TWNavigationViewController

+ (void)initialize{
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [[NSMutableDictionary alloc] init];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *disabledTextAttrs = [[NSMutableDictionary alloc] init];
    disabledTextAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    disabledTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [item setTitleTextAttributes:disabledTextAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_back" highlighedImage:@"navigationbar_back_highlighted" target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_more" highlighedImage:@"navigationbar_more_highlighted" target:self action:@selector(more)];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)more{
    [self popToRootViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
