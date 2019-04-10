//
//  ToDoTool.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoTool.h"

@implementation ToDoTool


/**
 获取当前时间戳
 */
+ (NSString*)getCurrentTimestamp {
    NSDate* dat = [NSDate date];
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString*timeString = [dateFormatter stringFromDate:dat];
    return timeString;
}

+ (NSString *)getStartTimeWithTime:(NSString *)time {
    //计算时间差
    NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSDateFormatter *dateFormatter = [self dateFormatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];

    NSDate *detaildate = [dateFormatter dateFromString:time];
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
        NSString *timeStr = [self formateDateThisYearWithDate:detaildate];
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
+ (NSString *)formateDateThisYearWithDate:(NSDate *)needFormatDate {
    // 实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [self dateFormatter];
    NSDate *nowDate = [NSDate date];
    
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearStr = [dateFormatter stringFromDate:needFormatDate];
    NSString *nowYear = [dateFormatter stringFromDate:nowDate];
    
    NSString *dateStr = @"";
    if ([yearStr isEqualToString:nowYear]) {
        ////  在同一年
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        dateStr = [dateFormatter stringFromDate:needFormatDate];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        dateStr = [dateFormatter stringFromDate:needFormatDate];
    }
    
    return dateStr;
}

+ (NSDateFormatter *)dateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    return dateFormatter;
}


/**
 
  * 开始到结束的时间差
 
  */

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 *3600)%3600;
    int day = (int)value / (24 *3600);
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house !=0) {
        str = [NSString stringWithFormat:@"%d小时%d分%d秒",house,minute,second];
    }else if (day==0 && house==0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%d秒",second];
    }
    return str;
    
    
}

+ (NSInteger)Time:(NSString *)firstTime lagerThanTime:(NSString *)secondTime {
    //计算时间差
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *startD =[date dateFromString:firstTime];
    NSDate *endD = [date dateFromString:secondTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = start - end;
    if (value == 0) {
        return 0;
    }else if (value > 0) {
        return 1;
    }else {
        return -1;
    }
}

@end
