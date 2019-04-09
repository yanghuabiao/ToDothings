//
//  GODDBHelper.m
//  FMDB_Demo
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 张冬冬. All rights reserved.
//

#import "GODDBHelper.h"
#import <BGFMDB/BGDB.h>

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

- (BOOL)god_saveOrUpdate:(ToDoMainModel *)todo {
    return [todo bg_saveOrUpdate];
}

- (NSArray<ToDoMainModel *> *)god_queryWithType:(ToDoThingsType)type {
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"type"),bg_sqlValue(@(type))];
    return [ToDoMainModel bg_find:@"ToDo" where:where];
}

- (BOOL)god_delete:(NSNumber *)pk {
    NSString* where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"bg_id"),bg_sqlValue(pk)];
    return [ToDoMainModel bg_delete:@"ToDo" where:where];
}


@end
