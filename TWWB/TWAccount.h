//
//  TWAccount.h
//  TWWB
//
//  Created by TooWalker on 1/5/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TWAccount : NSObject <NSCoding>

@property (nonatomic, copy) NSString *access_token;
@property (nonatomic, copy) NSNumber *expires_in;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, strong) NSDate *created_time;
@property (nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
