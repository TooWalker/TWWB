//
//  TWSecondTempViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWSecondTempViewController.h"
#import "TWThirdTempViewController.h"
@interface TWSecondTempViewController ()

@end

@implementation TWSecondTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TWThirdTempViewController *thirdController = [[TWThirdTempViewController alloc] init];
    thirdController.title = @"第三个控制器";
    [self.navigationController pushViewController:thirdController animated:YES];
}

@end
