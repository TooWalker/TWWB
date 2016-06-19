//
//  TWStatusCell.m
//  TWWB
//
//  Created by TooWalker on 1/8/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWStatusCell.h"
#import "TWStatus.h"
#import "TWUser.h"
#import "UIImageView+WebCache.h"
#import "TWStatusFrame.h"
#import "TWPhoto.h"
#import "TWStatusToolbar.h"
#import "TWStatusPhotosView.h"
#import "TWIconView.h"
@interface TWStatusCell()

/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) TWIconView *iconView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 会员 */
@property (nonatomic, weak) UIImageView *vipImageView;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 配图 */
@property (nonatomic, weak) TWStatusPhotosView *photosImageView;


/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetedView;
/** 转发微博正文 */
@property (nonatomic, weak) UILabel *retweetedContentLabel;
/** 转发微博配图 */
@property (nonatomic, weak) TWStatusPhotosView *retweetedPhotosImageView;

@property (nonatomic, weak) TWStatusToolbar *toolbarView;

@end


@implementation TWStatusCell

+ (TWStatusCell *)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"statuses";
    TWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        cell = [[TWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupOriginal];
        [self setupRetweet];
        [self setupToolbar];
    }
    return self;
}

- (void)setupOriginal{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /** 头像 */
    TWIconView *avatarImageView = (TWIconView *)[[UIImageView alloc] init];
    [originalView addSubview:avatarImageView];
    self.iconView = avatarImageView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = TWStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    /** 会员 */
    UIImageView *vipImageView = [[UIImageView alloc] init];
    [originalView addSubview:vipImageView];
    vipImageView.contentMode = UIViewContentModeCenter;
    self.vipImageView = vipImageView;
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = TWStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = TWStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = TWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    /** 配图 */
    TWStatusPhotosView *photoImageView = [[TWStatusPhotosView alloc] init];
    [originalView addSubview:photoImageView];
    self.photosImageView = photoImageView;
}

- (void)setupRetweet{
    
    UIView *retweetedView = [[UIView alloc] init];
    [self.contentView addSubview:retweetedView];
    self.retweetedView = retweetedView;
    
    UILabel *retweetedContentLabel = [[UILabel alloc] init];
    retweetedContentLabel.font = TWStatusCellRetweetContentFont;
    retweetedContentLabel.numberOfLines = 0;
    [retweetedView addSubview:retweetedContentLabel];
    self.retweetedContentLabel = retweetedContentLabel;
    
    TWStatusPhotosView *retweetedPhotoImageView = [[TWStatusPhotosView alloc] init];
    [retweetedView addSubview:retweetedPhotoImageView];
    self.retweetedPhotosImageView = retweetedPhotoImageView;
}

- (void)setupToolbar{
    TWStatusToolbar *toolbarView = [TWStatusToolbar toolbar];
    [self.contentView addSubview:toolbarView];
    self.toolbarView = toolbarView;
}

- (void)setStatusFrame:(TWStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    TWStatus *status = statusFrame.status;
    TWUser *user = status.user;
    TWStatus *retweetedStatus = status.retweeted_status;
    
    self.toolbarView.status = status;
    
    /** 原创微博整体 */
    self.originalView.frame = statusFrame.originalViewF;
    self.originalView.backgroundColor = [UIColor whiteColor];
    
    /** 头像 */
    self.iconView.frame = statusFrame.avatarImageViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 昵称 */
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    /** 会员 */
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        self.nameLabel.textColor = [UIColor orangeColor];
        
        self.vipImageView.frame = statusFrame.vipImageViewF;
        NSString *vipRankPhoto = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipRankPhoto];
    } else {
        self.vipImageView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    
    /** 时间 */
    NSString *creatTime = status.created_at;
    CGFloat timeX = self.nameLabel.x;
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + TWStatusCellBorderW;
    CGSize timeSize = [creatTime sizeWithFont:TWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = creatTime;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + TWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:TWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    /** 正文 */
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    /** 配图 */
    if (status.pic_urls.count) {
        self.photosImageView.hidden = NO;
        self.photosImageView.frame = statusFrame.photoImageViewF;
        self.photosImageView.photos = status.pic_urls;
    } else {
        self.photosImageView.hidden = YES;
    }
    
    if (retweetedStatus) {
        self.retweetedView.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.000];
        self.retweetedView.hidden = NO;
        /** 转发微博正文 */
        NSString *retweetedText = [NSString stringWithFormat:@"@%@:%@", retweetedStatus.user.name, retweetedStatus.text];
        self.retweetedContentLabel.text = retweetedText;
        self.retweetedContentLabel.frame = statusFrame.retweetedContentLabelF;
        if (retweetedStatus.pic_urls.count) {
            
            self.retweetedPhotosImageView.hidden = NO;
            /** 转发微博配图 */
            self.retweetedPhotosImageView.frame = statusFrame.retweetedPhotoImageViewF;
            self.retweetedPhotosImageView.photos = retweetedStatus.pic_urls;
        } else {
            self.retweetedPhotosImageView.hidden = YES;
        }
        /** 转发微博整体 */
        self.retweetedView.frame = statusFrame.retweetedViewF;
    } else {
        self.retweetedView.hidden = YES;
    }
    self.toolbarView.frame = statusFrame.toolbarViewF;
}

@end