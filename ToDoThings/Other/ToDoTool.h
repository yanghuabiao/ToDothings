//
//  ToDoTool.h
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTool : NSObject


/**
 获取当前时间戳
 */
+ (NSString*)getCurrentTimestamp;
//转换开始时间
+ (NSString *)getStartTimeWithTime:(NSString *)time;
/**
 按照发生的时间。当超过今年后，会从【月日时分】变成【年月日时分】
 
 timestamp: 时间戳字符串
 **/
+ (NSString *)formateDateThisYearWithTimestamp:(NSString *)timestamp;
/**
 
  * 开始到结束的时间差
 
  */

+ (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
+ (NSInteger)Time:(NSString *)firstTime lagerThanTime:(NSString *)secondTime ;
@end

NS_ASSUME_NONNULL_END
