//
//  TWStatus.h
//  TWWB
//
//  Created by TooWalker on 1/7/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWUser.h"
#import "TWPhoto.h"

@interface TWStatus : NSObject

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) TWUser *user;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) NSArray *pic_urls;

@property (nonatomic, strong) TWStatus *retweeted_status;
@property (nonatomic, assign) int reposts_count;
@property (nonatomic, assign) int comments_count;
@property (nonatomic, assign) int attitudes_count;

@end
