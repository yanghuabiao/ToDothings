//
//  ToDoEdtitView.h
//  ToDoThings
//
//  Created by Maker on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDoMainModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoEdtitView : UIView

/** 展示view */
-(void)show;
- (void)showWithModel:(ToDoMainModel *)model;
-(void)dismissAndRemove;


@end

NS_ASSUME_NONNULL_END
