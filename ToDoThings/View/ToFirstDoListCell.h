//
//  ToFirstDoListCell.h
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoMainModel.h"
@class ToFirstDoListCell;
@protocol ToFirstDoListCellDelegate <NSObject>

- (void)clickEditWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model;

@end

NS_ASSUME_NONNULL_BEGIN

@interface ToFirstDoListCell : UITableViewCell

@property (nonatomic, strong) ToDoMainModel *model;
@property (nonatomic, weak) id<ToFirstDoListCellDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
