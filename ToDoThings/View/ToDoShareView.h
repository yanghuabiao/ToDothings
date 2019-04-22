//
//  ToDoShareView.h
//  ToDoThings
//
//  Created by Maker on 2019/4/17.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ToDoMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoShareView : UIView

- (void)showWithModel:(ToDoMainModel *)model;

@end

NS_ASSUME_NONNULL_END
