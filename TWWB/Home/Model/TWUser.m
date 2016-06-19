//
//  TWUser.m
//  TWWB
//
//  Created by TooWalker on 1/7/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWUser.h"

@implementation TWUser

-(void)setMbtype:(int)mbtype{
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end
