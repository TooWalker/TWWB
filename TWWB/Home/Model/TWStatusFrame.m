//
//  TWStatusFrame.m
//  TWWB
//
//  Created by TooWalker on 1/8/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWStatusFrame.h"
#import "TWStatus.h"
#import "TWUser.h"
#import "TWStatusPhotosView.h"

#define TWStatusCellMargin 10

@implementation TWStatusFrame

- (void)setStatus:(TWStatus *)status{
    _status = status;
    
    TWUser *user = status.user;
    TWStatus *retweetedStatus = status.retweeted_status;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /** 头像 */
    CGFloat avatarX = TWStatusCellBorderW;
    CGFloat avaterY = TWStatusCellBorderW;
    CGFloat avaterWH = 35;
    self.avatarImageViewF = CGRectMake(avatarX, avaterY, avaterWH, avaterWH);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(self.avatarImageViewF) + TWStatusCellBorderW;
    CGFloat nameY = avaterY;
    CGSize nameSize = [user.name sizeWithFont:TWStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    /** 会员 */
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + TWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipImageViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + TWStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithFont:TWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + TWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:TWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = avatarX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.avatarImageViewF), CGRectGetMaxY(self.timeLabelF)) + TWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:TWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    CGFloat originalH = 0;
    /** 配图 */
    if (status.pic_urls.count) {
        CGFloat photoX = TWStatusCellBorderW;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + TWStatusCellBorderW;
        self.photoImageViewF = (CGRect){{photoX, photoY}, [TWStatusPhotosView sizeWithPhotosCount:status.pic_urls.count]};
        
        originalH = CGRectGetMaxY(self.photoImageViewF) + TWStatusCellBorderW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelF) + TWStatusCellBorderW;
    }

    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = TWStatusCellMargin;
    CGFloat originalW = cellW;

    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);

    CGFloat toolbarX = 0;
    CGFloat toolbarY = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    if (retweetedStatus) {
        
        /** 转发微博正文 */
        CGFloat retweetedContentX = TWStatusCellBorderW;
        CGFloat retweetedContentY = TWStatusCellBorderW;
        NSString *retweetedText = [NSString stringWithFormat:@"@%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        CGSize retweetedContentSize = [retweetedText sizeWithFont:TWStatusCellRetweetContentFont maxW:maxW];
        self.retweetedContentLabelF = (CGRect){{retweetedContentX, retweetedContentY}, retweetedContentSize};
        
        CGFloat retweetedViewH = 0;
        if (retweetedStatus.pic_urls.count) {
            /** 转发微博配图 */
            CGFloat retweetedPhotoX = TWStatusCellBorderW;
            CGFloat retweetedPhotoY = CGRectGetMaxY(self.retweetedContentLabelF) + TWStatusCellBorderW;

            self.retweetedPhotoImageViewF = (CGRect){{retweetedPhotoX, retweetedPhotoY}, [TWStatusPhotosView sizeWithPhotosCount:retweetedStatus.pic_urls.count]};
            
            retweetedViewH = CGRectGetMaxY(self.retweetedPhotoImageViewF) + TWStatusCellBorderW;
        } else {
            retweetedViewH = CGRectGetMaxY(self.retweetedContentLabelF) + TWStatusCellBorderW;
        }

        /** 转发微博整体 */
        CGFloat retweetedViewX = 0;
        CGFloat retweetedViewY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetedViewW = cellW;

        self.retweetedViewF = CGRectMake(retweetedViewX, retweetedViewY, retweetedViewW, retweetedViewH);
        
        toolbarY = CGRectGetMaxY(self.retweetedViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.originalViewF);
    }
    
    self.toolbarViewF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    self.cellHeight = CGRectGetMaxY(self.toolbarViewF);
}

@end
