//
//  TWTabBar.m
//  TWWB
//
//  Created by TooWalker on 12/29/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import "TWTabBar.h"

@interface TWTabBar ()
@property (nonatomic, weak) UIButton *composeButton;
@end

@implementation TWTabBar
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *composeButton = [[UIButton alloc] init];
        
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [composeButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [composeButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        composeButton.size = composeButton.currentBackgroundImage.size;
        [composeButton addTarget:self action:@selector(composeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:composeButton];
        self.composeButton = composeButton;
    }
    return self;
}

- (void)composeButtonClick{
    if ([self.delegate respondsToSelector:@selector(didClickComposeButton:)]){
        [self.delegate didClickComposeButton:self];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.composeButton.centerX = self.frame.size.width * 0.5;
    self.composeButton.centerY = self.frame.size.height * 0.5;
    
    CGFloat buttonWidth = self.window.width / 5;

    int tabBarButtonIndex = 0;
    Class class = NSClassFromString(@"UITabBarButton");
    for (UIView *child in self.subviews) {
        if ([child isKindOfClass:class]) {
            child.x = tabBarButtonIndex * buttonWidth;
            child.width = buttonWidth;
            tabBarButtonIndex++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex++;
            }
        }
    }
}

@end
