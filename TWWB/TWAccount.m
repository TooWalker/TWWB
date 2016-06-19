//
//  TWAccount.m
//  TWWB
//
//  Created by TooWalker on 1/5/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWAccount.h"

@implementation TWAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    TWAccount *account = [[self alloc] init];
    account.access_token = dict[@"access_token"];
    account.uid = dict[@"uid"];
    account.expires_in = dict[@"expires_in"];
    account.created_time = [NSDate date];
    return account;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token =  [aDecoder decodeObjectForKey:@"access_token"];
        self.uid =  [aDecoder decodeObjectForKey:@"uid"];
        self.expires_in =  [aDecoder decodeObjectForKey:@"expires_in"];
        self.created_time =  [aDecoder decodeObjectForKey:@"created_time"];
        self.name =  [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
