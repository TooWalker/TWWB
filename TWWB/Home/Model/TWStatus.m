//
//  TWStatus.m
//  TWWB
//
//  Created by TooWalker on 1/7/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "TWStatus.h"

@implementation TWStatus

+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"pic_urls" : @"TWPhoto"
             };
}

- (NSString *)created_at{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
//    _created_at = @"Tue Sep 30 17:06:25 +0800 2014";
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    NSDate *createDate = [fmt dateFromString:_created_at];
    NSDate *now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) {
        if ([createDate isYesterday]) {
            fmt.dateFormat  = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) {
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) {
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else {
                return @"刚刚";
            }
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else {
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}

- (void)setSource:(NSString *)source{
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    NSString *str = [source substringWithRange:range];
    _source = [NSString stringWithFormat:@"来自%@", str];
}
@end
