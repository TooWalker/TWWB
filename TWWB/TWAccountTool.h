//
//  TWAccountTool.h
//  TWWB
//
//  Created by TooWalker on 1/5/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWAccount.h"

@interface TWAccountTool : NSObject

+ (void)saveAccount:(TWAccount *)account;
+ (TWAccount *)account;

@end
