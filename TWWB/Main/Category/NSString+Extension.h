//
//  NSString+Extension.h
//  TWWB
//
//  Created by TooWalker on 2/29/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;
@end
