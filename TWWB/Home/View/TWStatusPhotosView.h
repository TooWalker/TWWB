//
//  TWStatusPhotosView.h
//  TWWB
//
//  Created by TooWalker on 2/29/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWStatusPhotosView : UIView

@property (nonatomic, strong) NSArray *photos;
+ (CGSize)sizeWithPhotosCount:(NSUInteger)count;

@end
