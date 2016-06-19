//
//  UIBarButtonItem+Extension.h
//  TWWB
//
//  Created by TooWalker on 12/29/15.
//  Copyright © 2015 TooWalker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName highlighedImage:(NSString *)highlighedImageName target:(id)target action:(SEL)action;

@end
