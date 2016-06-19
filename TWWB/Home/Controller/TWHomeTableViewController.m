//
//  TWHomeTableViewController.m
//  TWWB
//
//  Created by TooWalker on 12/28/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWHomeTableViewController.h"
#import "AFNetworking.h"
#import "TWAccountTool.h"
#import "UIImageView+WebCache.h"
#import "TWStatus.h"
#import "MJExtension.h"
#import "TWLoadMoreFooter.h"
#import "TWStatusCell.h"
#import "TWStatusFrame.h"

@interface TWHomeTableViewController ()
/** 存储微博状态的模型数组 */
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation TWHomeTableViewController

- (NSMutableArray *) statusFrames{
    if (!_statusFrames){
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.827 alpha:1.000];
    
    [self setUpNavigationItem];
    
    [self setupUserInfo];
    
    [self setupPulldown];
    
    [self setupPullup];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(showUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)showUnreadCount{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TWAccount *account = [TWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        NSString *unreadCount =  [responseObject[@"status"] description];
        if ([unreadCount isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = unreadCount;
            [UIApplication sharedApplication].applicationIconBadgeNumber = unreadCount.intValue;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TWLog(@"error-%@", error);
    }];
}

- (void)setUpNavigationItem{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highlighedImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(friendSearch)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highlighedImage:@"navigationbar_pop_highlighted" target:self action:@selector(scan)];
}

- (void)setupUserInfo{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TWAccount *account = [TWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        TWUser *user = [TWUser mj_objectWithKeyValues:responseObject];
        account.name = user.name;
        [TWAccountTool saveAccount:account];
        self.navigationItem.title = account.name;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TWLog(@"error-%@", error);
    }];
}

- (void)setupPulldown{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatuses:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    [control beginRefreshing];
    [self loadNewStatuses:control];
}

- (void)setupPullup{
    TWLoadMoreFooter *footer = [TWLoadMoreFooter footer];
    footer.hidden = YES;
//    [self.tableView setTableFooterView:footer];
    self.tableView.tableFooterView = footer;
}

- (void)loadNewStatuses:(UIRefreshControl *)control{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TWAccount *account = [TWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    TWStatusFrame *firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }

    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {

        NSArray *newStatus = [TWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFrameWithStatus:newStatus];
        
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        
        
        /** ****************************************************************** */
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        /** ****************************************************************** */
        
        
        [self.tableView reloadData];

        [self showNewStatusesCount:newStatus.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TWLog(@"error-%@", error);
    }];
    [control endRefreshing];
}

- (void)loadMoreStatuses{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    TWAccount *account = [TWAccountTool account];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    TWStatusFrame *lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        long long maxId =  lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        NSArray *newStatus = [TWStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        NSArray *newFrames = [self statusFrameWithStatus:newStatus];

        
        /** ****************************************************************** */
        [self.statusFrames addObjectsFromArray:newFrames];
        /** ****************************************************************** */
        
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        TWLog(@"error-%@", error);
    }];
    self.tableView.tableFooterView.hidden = YES;
}

- (NSArray *)statusFrameWithStatus:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (TWStatus *status in statuses) {
        TWStatusFrame *f = [[TWStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

- (void)showNewStatusesCount:(NSUInteger)count{
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.width = self.view.bounds.size.width;
    label.height = 35;
    label.x = 0;
    label.y = 64 - label.height;
    
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    if (count) {
        label.text = [NSString stringWithFormat:@"更新了%ld条微博", count];
    }else{
        label.text = @"没有最新的微博";
    }
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
    
    
}

- (void)friendSearch{
    TWLog(@"friendSearch");
}

- (void)scan{
    TWLog(@"scan");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWStatusCell *statusCell = [TWStatusCell cellWithTableView:tableView];
    statusCell.statusFrame = self.statusFrames[indexPath.row];
    return statusCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TWStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
        [self loadMoreStatuses];
    }
}

@end
