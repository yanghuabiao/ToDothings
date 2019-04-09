//
//  ToFirstDoListCell.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToFirstDoListCell.h"
#import <Masonry.h>
#import "ToDoTool.h"

@interface ToFirstDoListCell ()

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *contentLb;
@property (nonatomic, strong) UILabel *statusLb;
@property (nonatomic, strong) UILabel *statTimeLb;
@property (nonatomic, strong) UILabel *endTimeLb;
@property (nonatomic, strong) UIImageView *clockIV;
@property (nonatomic, strong) UIImageView *editIv;

@property (nonatomic, strong) UIView *lineView_first;
@property (nonatomic, strong) UIView *lineView_second;
@property (nonatomic, strong) UIView *lineView_thrid;

@property (nonatomic, strong) UIImageView *bgv;


@end

@implementation ToFirstDoListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setModel:(ToDoMainModel *)model {
    _model = model;
    self.titleLb.text = model.title;
    self.contentLb.text = model.content;
    if (model.isOpenNoti) {
        self.statusLb.text = @"通知已开启";
        self.statusLb.textColor = [UIColor whiteColor];
        
        self.clockIV.image = [UIImage imageNamed:@"hasNoti"];
    }else {
        self.statusLb.text = @"未开启通知";
        self.statusLb.textColor = [UIColor colorWithRed:137 green:137 blue:137 alpha:1];
        
        self.clockIV.image = [UIImage imageNamed:@"noNoti"];
    }
    self.statTimeLb.text = [ToDoTool getStartTimeWithTime:model.startTime];
    self.endTimeLb.text = [ToDoTool formateDateThisYearWithTimestamp:model.endTime];
    
}

- (void)clickEdit {
    if ([self.delegate respondsToSelector:@selector(clickEditWithCell:model:)]) {
        [self.delegate clickEditWithCell:self model:self.model];
    }
}

- (void)setupUI {
    [self.contentView addSubview:self.bgv];
    [self.bgv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-20);
    }];
    
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = self.bounds;
    [self.bgv addSubview:effectview];
    [effectview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.bgv addSubview:self.lineView_first];
    [self.lineView_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(30);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgv addSubview:self.lineView_second];
    [self.lineView_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(self.lineView_first.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.bgv addSubview:self.lineView_thrid];
    [self.lineView_thrid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(81);
        make.bottom.mas_equalTo(-50);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgv addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self.lineView_first.mas_top);
    }];
    
    [self.bgv addSubview:self.editIv];
    [self.editIv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self.titleLb);
        make.width.height.mas_equalTo(15);
    }];
    
    [self.bgv addSubview:self.contentLb];
    [self.contentLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView_second.mas_right).mas_equalTo(8);
        make.top.mas_equalTo(self.lineView_first.mas_bottom).mas_equalTo(8);
        make.right.mas_equalTo(-10);
    }];
    
    [self.bgv addSubview:self.clockIV];
    [self.clockIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(27.5);
        make.top.mas_equalTo(self.lineView_first.mas_bottom).mas_equalTo(35);
        make.width.height.mas_equalTo(25);
    }];
    
    [self.bgv addSubview:self.statusLb];
    [self.statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView_first.mas_bottom).mas_equalTo(65);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.lineView_second.mas_left);
    }];
    
    [self.bgv addSubview:self.statTimeLb];
    [self.statTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView_second.mas_right).mas_equalTo(8);
        make.top.mas_equalTo(self.lineView_thrid.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.bgv addSubview:self.endTimeLb];
    [self.endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lineView_thrid.mas_bottom);
        make.bottom.mas_equalTo(0);
    }];
}


//生成一张毛玻璃图片
- (UIImage*)blur:(UIImage*)theImage
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:15.0f] forKey:@"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return returnImage;
}

- (void)dealloc {
    self.delegate = nil;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15];
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

- (UILabel *)contentLb {
    if (!_contentLb) {
        _contentLb = [[UILabel alloc] init];
        _contentLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:17];
        _contentLb.textAlignment = NSTextAlignmentLeft;
        _contentLb.numberOfLines = 2;
    }
    return _contentLb;
}

- (UILabel *)statusLb {
    if (!_statusLb) {
        _statusLb = [[UILabel alloc] init];
        _statusLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _statusLb.textAlignment = NSTextAlignmentCenter;
    }
    return _statusLb;
}

- (UILabel *)statTimeLb {
    if (!_statTimeLb) {
        _statTimeLb = [[UILabel alloc] init];
        _statTimeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _statTimeLb.textAlignment = NSTextAlignmentLeft;
    }
    return _statTimeLb;
}

- (UILabel *)endTimeLb {
    if (!_endTimeLb) {
        _endTimeLb = [[UILabel alloc] init];
        _endTimeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:12];
        _endTimeLb.textAlignment = NSTextAlignmentLeft;
    }
    return _endTimeLb;
}

- (UIView *)lineView_first {
    if (!_lineView_first) {
        _lineView_first = [UIView new];
        _lineView_first.backgroundColor = [UIColor colorWithRed:237 green:237 blue:237 alpha:1];
    }
    return _lineView_first;
}

- (UIView *)lineView_second {
    if (!_lineView_second) {
        _lineView_second = [UIView new];
        _lineView_second.backgroundColor = [UIColor colorWithRed:237 green:237 blue:237 alpha:1];
    }
    return _lineView_second;
}

- (UIView *)lineView_thrid {
    if (!_lineView_thrid) {
        _lineView_thrid = [UIView new];
        _lineView_thrid.backgroundColor = [UIColor colorWithRed:237 green:237 blue:237 alpha:1];
    }
    return _lineView_thrid;
}

- (UIImageView *)bgv {
    if (!_bgv) {
        _bgv = [UIImageView new];
        _bgv.backgroundColor = [UIColor whiteColor];
        _bgv.layer.cornerRadius = 4;
        _bgv.layer.masksToBounds =YES;
        _bgv.layer.borderColor = [UIColor colorWithRed:237 green:237 blue:237 alpha:1].CGColor;
        _bgv.layer.borderWidth = 1.0f;
        _bgv.image = [self blur:[UIImage imageNamed:@"背景"]];
    }
    return _bgv;
}

- (UIImageView *)clockIV {
    if (!_clockIV) {
        _clockIV = [[UIImageView alloc] init];
        _clockIV.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _clockIV;
}


- (UIImageView *)editIv {
    if (!_editIv) {
        _editIv = [[UIImageView alloc] init];
        _editIv.contentMode = UIViewContentModeScaleAspectFit;
        _editIv.image = [UIImage imageNamed:@"edit"];
        _editIv.userInteractionEnabled = YES;
        [_editIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEdit)]];
    }
    return _editIv;
}
@end
