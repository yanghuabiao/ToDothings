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
- (BOOL)god_saveOrUpdate:(ToDoMainModel *)todo;
- (NSArray<ToDoMainModel *> *)god_queryWithType:(ToDoThingsType)type;
- (BOOL)god_delete:(NSNumber *)pk;
@end

NS_ASSUME_NONNULL_END
