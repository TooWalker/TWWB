//
//  TWStatusCell.h
//  TWWB
//
//  Created by TooWalker on 1/8/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TWStatusFrame;

@interface TWStatusCell : UITableViewCell

+ (TWStatusCell *)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) TWStatusFrame *statusFrame;

@end
