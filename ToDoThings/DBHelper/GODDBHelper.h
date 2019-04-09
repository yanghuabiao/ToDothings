//
//  GODDBHelper.h
//  FMDB_Demo
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface GODDBHelper : NSObject
+ (instancetype)sharedHelper;
//保存或更新：表中主键存在就更新，表中没有该主键则新增
- (BOOL)god_saveOrUpdate:(ToDoMainModel *)todo;
//根据 type 获取模型数组
- (NSArray<ToDoMainModel *> *)god_queryWithType:(ToDoThingsType)type;
//根据主键删除模型
- (BOOL)god_delete:(NSNumber *)pk;
//清空数据库
- (void)god_clear;
@end

NS_ASSUME_NONNULL_END
