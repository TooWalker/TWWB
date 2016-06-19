//
//  TWFirstTempViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWFirstTempViewController.h"
#import "TWSecondTempViewController.h"
@interface TWFirstTempViewController ()

@end

@implementation TWFirstTempViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    TWSecondTempViewController *secondController = [[TWSecondTempViewController alloc] init];
    secondController.title = @"第二个控制器";
    [self.navigationController pushViewController:secondController animated:YES];
}
@end
