//
//  TWLoadMoreFooter.m
//  TWWB
//
//  Created by TooWalker on 1/7/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWLoadMoreFooter.h"

@implementation TWLoadMoreFooter

+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"TWLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
