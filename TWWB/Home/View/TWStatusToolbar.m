//
//  TWStatusToolbar.m
//  TWWB
//
//  Created by TooWalker on 2/27/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWStatusToolbar.h"
#import "TWStatus.h"
@interface TWStatusToolbar()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end

@implementation TWStatusToolbar

- (NSMutableArray *)btns{
    if (!_btns){
        self.btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (NSMutableArray *)dividers{
    if (!_dividers){
        self.dividers = [[NSMutableArray alloc] init];
    }
    return _dividers;
}

+ (instancetype)toolbar{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self setupBtn:@"timeline_icon_retweet" title:@"转发"];
        self.commentBtn = [self setupBtn:@"timeline_icon_comment" title:@"评论"];
        self.attitudeBtn = [self setupBtn:@"timeline_icon_unlike" title:@"赞"];
        
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (UIButton *)setupBtn:(NSString *)icon title:(NSString *)title{
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    
    [self.btns addObject:btn];
    [self addSubview:btn];
    return btn;
}

- (void)setupDivider{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self.dividers addObject:divider];
    [self addSubview:divider];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    NSUInteger btnCount = self.btns.count;
    CGFloat btnY = 0;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btns[i];
        btn.x = i * btnW;
        btn.y = btnY;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    NSUInteger dividerCount = self.dividers.count;
    CGFloat dividerY = 0;
    CGFloat dividerW = 1;
    CGFloat dividerH = self.height;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.x = (i + 1) * btnW;
        divider.y = dividerY;
        divider.width = dividerW;
        divider.height = dividerH;
    }
}

- (void)setStatus:(TWStatus *)status{
    _status = status;
    [self setCount:status.reposts_count onButton:self.repostBtn withTitle:@"转发"];
    [self setCount:status.comments_count onButton:self.commentBtn withTitle:@"评论"];
    [self setCount:status.attitudes_count onButton:self.attitudeBtn withTitle:@"赞"];
}

- (void)setCount:(int)count onButton:(UIButton *)btn withTitle:(NSString *)title{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d", count];
        } else {
            CGFloat wan = count / 10000;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end









