//
//  TWStatusFrame.h
//  TWWB
//
//  Created by TooWalker on 1/8/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TWStatusCellNameFont [UIFont systemFontOfSize:15]
#define TWStatusCellTimeFont [UIFont systemFontOfSize:12]
#define TWStatusCellSourceFont TWStatusCellTimeFont
#define TWStatusCellContentFont [UIFont systemFontOfSize:14]

#define TWStatusCellRetweetContentFont [UIFont systemFontOfSize:13]

#define TWStatusCellBorderW 10

@class TWStatus;
@interface TWStatusFrame : NSObject

@property (nonatomic, strong) TWStatus *status;

/** 原创微博整体 */
@property (nonatomic, assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic, assign) CGRect avatarImageViewF;
/** 昵称 */
@property (nonatomic, assign) CGRect nameLabelF;
/** 会员 */
@property (nonatomic, assign) CGRect vipImageViewF;
/** 时间 */
@property (nonatomic, assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic, assign) CGRect contentLabelF;
/** 配图 */
@property (nonatomic, assign) CGRect photoImageViewF;

/** 转发微博整体 */
@property (nonatomic, assign) CGRect retweetedViewF;
/** 转发微博正文 */
@property (nonatomic, assign) CGRect retweetedContentLabelF;
/** 转发微博配图 */
@property (nonatomic, assign) CGRect retweetedPhotoImageViewF;

@property (nonatomic, assign) CGRect toolbarViewF;

@property (nonatomic, assign) CGFloat cellHeight;

@end
