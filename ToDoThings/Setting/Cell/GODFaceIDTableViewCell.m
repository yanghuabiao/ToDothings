//
//  GODFaceIDTableViewCell.m
//  ToDoThings
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GODFaceIDTableViewCell.h"
#import "GODDefine.h"

@implementation GODFaceIDTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7.5, 30, 30)];
        self.leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.leftImageView];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 7.5, 100, 30)];
        self.titleLabel.textColor = [UIColor colorWithRed:79/255.0 green:86/255.0 blue:113/255.0 alpha:1.f];
        [self.contentView addSubview:self.titleLabel];
        
        self.faceIdSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(ScreenWidth - 51 - 10, 7, 51, 31)];
        self.faceIdSwitch.onTintColor = [UIColor colorWithRed:59/255.0 green:122/255.0 blue:209/255.0 alpha:1.f];
        [self.contentView addSubview:self.faceIdSwitch];
    }
    return self;
}

@end
