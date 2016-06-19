//
//  TWTabBar.h
//  TWWB
//
//  Created by TooWalker on 12/29/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWTabBar;

@protocol TWTabBarDelegate <UITabBarDelegate>
@optional
- (void)didClickComposeButton:(TWTabBar *)tabBar;
@end

@interface TWTabBar : UITabBar
@property (nonatomic, weak) id<TWTabBarDelegate> delegate;
@end
