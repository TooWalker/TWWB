//
//  TWMessageTableViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWMessageTableViewController.h"
#import "TWFirstTempViewController.h"
@interface TWMessageTableViewController ()

@end

@implementation TWMessageTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    self =  [super initWithStyle:style];
    if (self) {
//        self.navigationItem.leftBarButtonItem = [[UIButton alloc] init];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)composeMsg{
    TWLog(@"composeMsg--写私信");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"messageCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld", (long)indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TWFirstTempViewController *firstController = [[TWFirstTempViewController alloc] init];
    firstController.title = @"第一个控制器";
    [self.navigationController pushViewController:firstController animated:YES];
}

@end
