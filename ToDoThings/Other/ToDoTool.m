//
//  ToDoTool.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoTool.h"

@implementation ToDoTool



+ (NSString *)getStartTimeWithTime:(NSString *)time {
    //计算时间差
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval startTime = [time doubleValue]*0.001;
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:startTime];
    //对比得到差值
    NSTimeInterval timeInterval = [detaildate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    //以下按自己需要使用
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    dayStr = [NSString stringWithFormat:@"%d",days];
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        NSString *timeStr = [self formateDateThisYearWithTimestamp:time];
        timeStr = [NSString stringWithFormat:@"%@ 已逾期", timeStr];
        return timeStr;
    }
    
    if (days) {
        return [NSString stringWithFormat:@"剩余时间  %@天%@:%@:%@", dayStr,hoursStr, minutesStr,secondsStr];
    } else if(hours){
        return [NSString stringWithFormat:@"剩余时间  %@:%@:%@", hoursStr,minutesStr,secondsStr];
    }else
        return [NSString stringWithFormat:@"剩余时间  %@:%@", minutesStr,secondsStr];

}

/**
 按照发生的时间。当超过今年后，会从【月日时分】变成【年月日时分】
 
 timestamp: 时间戳字符串
 **/
+ (NSString *)formateDateThisYearWithTimestamp:(NSString *)timestamp {
    // 实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [self dateFormatter];
    NSDate *nowDate = [NSDate date];
    NSDate *needFormatDate = [NSDate dateWithTimeIntervalSince1970:[timestamp doubleValue]];
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:needFormatDate];
    NSString *nowYear = [dateFormatter stringFromDate:nowDate];
    
    NSString *dateStr = @"";
    if ([yearStr isEqualToString:nowYear]) {
        ////  在同一年
        [dateFormatter setDateFormat:@"MM月dd日 HH:mm"];
        dateStr = [dateFormatter stringFromDate:needFormatDate];
    } else {
        [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        dateStr = [dateFormatter stringFromDate:needFormatDate];
    }
    
    return dateStr;
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    return dateFormatter;
}

@end
