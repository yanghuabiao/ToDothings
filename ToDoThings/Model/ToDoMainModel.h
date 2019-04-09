//
//  ToDoMainModel.h
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGFMDB/BGFMDB.h>
typedef NS_ENUM(NSInteger, ToDoThingsType){
    ToDoThingsTypeToDo = 0,//待办
    ToDoThingsTypeIsDoing,//正在处理
    ToDoThingsTypeToIsDone//已完成的
};


NS_ASSUME_NONNULL_BEGIN

@interface ToDoMainModel : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
//预计开始时间
@property (nonatomic, strong) NSString *startTime;
//预计结束时间
@property (nonatomic, strong) NSString *endTime;
//实际开始时间
@property (nonatomic, strong) NSString *realStartTime;
//实际结束时间
@property (nonatomic, strong) NSString *realEndTime;
//是否打开通知
@property (nonatomic, assign) BOOL isOpenNoti;
//是否展开cell
@property (nonatomic, assign) BOOL isOpenCell;

@property (nonatomic, assign) ToDoThingsType type;


@end

NS_ASSUME_NONNULL_END
