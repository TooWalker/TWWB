//
//  TWAccountTool.m
//  TWWB
//
//  Created by TooWalker on 1/5/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWAccountTool.h"
#define TWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

@implementation TWAccountTool

+ (void)saveAccount:(TWAccount *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:TWAccountPath];
}

+ (TWAccount *)account{
    TWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:TWAccountPath];

    long long expires_in = [account.expires_in longLongValue];
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    NSDate *now = [NSDate date];
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}
@end
