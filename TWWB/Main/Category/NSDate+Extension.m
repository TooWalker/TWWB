//
//  NSDate+Extension.m
//  TWWB
//
//  Created by TooWalker on 2/28/16.
//  Copyright © 2016 TooWalker. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:now];
    return dateCmps.year == nowCmps.year;
}

- (BOOL)isYesterday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comps = [calendar components:unit fromDate:self toDate:now options:0];
    return comps.year == 0 && comps.month == 0 && comps.day == 1;
}

- (BOOL)isToday{
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *now = [NSDate date];
//    
//    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
//    NSDateComponents *comps = [calendar components:unit fromDate:self toDate:now options:0];
//    return comps.year == 0 && comps.month == 0 && comps.day == 0;

    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *nowStr = [fmt stringFromDate:[NSDate date]];
    NSString *dateStr = [fmt stringFromDate:self];
    
    return [nowStr isEqualToString:dateStr];
}
@end
