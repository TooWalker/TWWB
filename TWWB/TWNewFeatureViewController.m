//
//  TWNewFeatureViewController.m
//  TWWB
//
//  Created by TooWalker on 1/3/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWNewFeatureViewController.h"
#import "TWTabBarViewController.h"
#define TWNewFeatureCount 4

@interface TWNewFeatureViewController () <UIScrollViewDelegate>
@property (nonatomic, weak) UIPageControl *pageControll;
@end

@implementation TWNewFeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat scrollViewW = scrollView.width;
    CGFloat scrollViewH = scrollView.height;
    for (int i = 0; i < TWNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollViewW;
        imageView.height = scrollViewH;
        imageView.x = i * scrollViewW;
        imageView.y = 0;
        
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d", i + 1];
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        if (i == 3) {
            [self setupLastImageView:imageView];
        }
    }
    
    scrollView.contentSize = CGSizeMake(scrollViewW * TWNewFeatureCount, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.centerX = self.view.centerX;
    pageControl.centerY = self.view.height - 50;
    pageControl.numberOfPages = TWNewFeatureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:1.000 green:0.380 blue:0.094 alpha:1.000];
    pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.741 alpha:1.000];
    [self.view addSubview:pageControl];
    self.pageControll = pageControl;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x / self.view.width;
    self.pageControll.currentPage = (int)(page + 0.5);
}

- (void)setupLastImageView:(UIImageView *)imageView{
    
    imageView.userInteractionEnabled = YES;
    
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = self.view.centerX;
    shareBtn.centerY = self.view.height * 0.65;
    [imageView addSubview:shareBtn];

    
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnClick) forControlEvents:UIControlEventTouchUpInside];
    startBtn.size = startBtn.currentBackgroundImage.size;
    NSLog(@"%@", NSStringFromCGSize(startBtn.size));
    startBtn.centerX = self.view.centerX;
    startBtn.centerY = self.view.height * 0.75;
    [imageView addSubview:startBtn];
}

- (void)shareBtnClick:(UIButton *) shareBtn{
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startBtnClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[TWTabBarViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
