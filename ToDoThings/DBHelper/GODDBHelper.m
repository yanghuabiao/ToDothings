//
//  GODDBHelper.m
//  FMDB_Demo
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import "GODDBHelper.h"
#import <BGFMDB/BGDB.h>
#import <UserNotifications/UserNotifications.h>
@interface GODDBHelper ()

@end

@implementation GODDBHelper
+ (instancetype)sharedHelper {
    static dispatch_once_t onceToken;
    static GODDBHelper *helper = nil;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc] init];
        [BGDB shareManager].sqliteName = @"FEE1DEAD";
    });
    return helper;
}

- (void)sendNoti {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadList" object:nil];
    });
}

- (BOOL)god_saveOrUpdate:(ToDoMainModel *)todo {
    [self removeLocalNoti:todo];
    [self addLocalNoti:todo];
    [self sendNoti];
    return [todo bg_saveOrUpdate];
}

- (NSArray<ToDoMainModel *> *)god_queryWithType:(ToDoThingsType)type {
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"type"),bg_sqlValue(@(type))];
    return [ToDoMainModel bg_find:@"ToDo" where:where];
}

- (BOOL)god_delete:(NSNumber *)pk {
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bg_id"),bg_sqlValue(pk)];
    ToDoMainModel *todo = [ToDoMainModel bg_find:@"ToDo" where:where].firstObject;
    [self removeLocalNoti:todo];
    [self sendNoti];
    return [ToDoMainModel bg_delete:@"ToDo" where:where];
}

- (void)god_clear {
    [ToDoMainModel bg_clear:@"ToDo"];
}

- (void)addLocalNoti:(ToDoMainModel *)todo {
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    //需创建一个包含待通知内容的 UNMutableNotificationContent 对象，注意不是 UNNotificationContent ,此对象为不可变对象。
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:todo.title arguments:nil];
    content.body = [NSString localizedUserNotificationStringForKey:todo.content arguments:nil];
    content.sound = [UNNotificationSound defaultSound];
    
    NSDateComponents *components = [self componentsWithDateStr:todo.startTime];
//    NSDateComponents *components = [self getDateComponentsWithTimeStamp:todo.startTime];
    UNCalendarNotificationTrigger  *dayTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:components repeats:NO];
    UNNotificationRequest* request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"%@", todo.bg_id]
                                                                          content:content trigger:dayTrigger];
    
    //添加推送成功后的处理！
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

- (void)removeLocalNoti:(ToDoMainModel *)todo {
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    //添加推送成功后的处理！
    [center removeDeliveredNotificationsWithIdentifiers:@[[NSString stringWithFormat:@"%@", todo.bg_id]]];
    [center removePendingNotificationRequestsWithIdentifiers:@[[NSString stringWithFormat:@"%@", todo.bg_id]]];
}

- (NSDateComponents *)componentsWithDateStr:(NSString *)dateStr {

    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *date=[formatter dateFromString:dateStr];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return components;
}

- (NSDateComponents *)getDateComponentsWithTimeStamp:(NSString *)timeStamp{
    
    NSTimeInterval time = 0;
    if (timeStamp.length == 10) {
        time = [timeStamp doubleValue];
    }else {
        time = [timeStamp doubleValue]/1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:date];
    return components;
}

@end
