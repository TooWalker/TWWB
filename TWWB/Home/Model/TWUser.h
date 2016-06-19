//
//  TWUser.h
//  TWWB
//
//  Created by TooWalker on 1/7/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    HWUserVerifiedTypeNone = -1, // 没有任何认证
    
    HWUserVerifiedPersonal = 0,  // 个人认证
    
    HWUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HWUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HWUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HWUserVerifiedDaren = 220 // 微博达人
} HWUserVerifiedType;

@interface TWUser : NSObject

@property (nonatomic, copy) NSString *idstr;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image_url;
@property (nonatomic, assign) int mbtype;
@property (nonatomic, assign) int mbrank;
@property (nonatomic, assign, getter=isVip) BOOL vip;
@property (nonatomic, assign) HWUserVerifiedType verified_type;

@end
