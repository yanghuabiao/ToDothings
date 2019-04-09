//
//  ToDoMainModel.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoMainModel.h"
#import "ToDoTool.h"

@implementation ToDoMainModel
- (NSString *)bg_tableName {
    return @"ToDo";
}

- (void)setType:(ToDoThingsType)type {
    _type = type;
    if (type == ToDoThingsTypeIsDoing) {
        self.realStartTime = [ToDoTool getCurrentTimestamp];
    }else if (type == ToDoThingsTypeIsDone) {
        self.realEndTime = [ToDoTool getCurrentTimestamp];
    }
}

@end
