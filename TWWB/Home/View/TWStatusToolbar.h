//
//  TWStatusToolbar.h
//  TWWB
//
//  Created by TooWalker on 2/27/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWStatus;

@interface TWStatusToolbar : UIView

+ (instancetype)toolbar;
@property (nonatomic, strong) TWStatus *status;

@end
