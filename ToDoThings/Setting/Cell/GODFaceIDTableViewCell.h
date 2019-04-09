//
//  GODFaceIDTableViewCell.h
//  ToDoThings
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GODFaceIDTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UISwitch *faceIdSwitch;
@end

NS_ASSUME_NONNULL_END
