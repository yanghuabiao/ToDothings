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

#define LineColor [UIColor colorWithRed:237 green:237 blue:237 alpha:1]

@interface ToDoTitleAndIVView : UIView


@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UIImageView *imgView;

@end


@implementation ToDoTitleAndIVView

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleLb.text = title;
}

- (void)setImg:(NSString *)imgStr {
    self.imgView.image = [UIImage imageNamed:imgStr];
}

- (void)setupUI {
    [self addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(30);
    }];
    
    [self addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_right).mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(15);
    }];
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:13];
        _titleLb.textColor = [UIColor grayColor];
    }
    return _titleLb;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}


@end


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
@property (nonatomic, strong) UIView *lineView_fouth;

@property (nonatomic, strong) UIImageView *bgv;


@property (nonatomic, strong) ToDoTitleAndIVView *strtBtn;
@property (nonatomic, strong) ToDoTitleAndIVView *delBtn;


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
    
    if (model.isOpenCell) {
        self.delBtn.hidden = NO;
        self.strtBtn.hidden = NO;
    }else {
        self.delBtn.hidden = YES;
        self.strtBtn.hidden = YES;
    }
    self.statTimeLb.text = [ToDoTool getStartTimeWithTime:model.startTime];
    self.endTimeLb.text = [ToDoTool formateDateThisYearWithTimestamp:model.endTime];
}

- (void)clickEdit {
    if ([self.delegate respondsToSelector:@selector(clickEditWithCell:model:)]) {
        [self.delegate clickEditWithCell:self model:self.model];
    }
}

- (void)clickStartBtn {
    if ([self.delegate respondsToSelector:@selector(clickStartWithCell:model:)]) {
        [self.delegate clickStartWithCell:self model:self.model];
    }
}

- (void)clickDeleteBtn {
    if ([self.delegate respondsToSelector:@selector(clickDeleteWithCell:model:)]) {
        [self.delegate clickDeleteWithCell:self model:self.model];
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
    
    [self.bgv addSubview:self.lineView_thrid];
    [self.lineView_thrid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(81);
        make.top.mas_equalTo(100);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgv addSubview:self.lineView_fouth];
    [self.lineView_fouth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(140);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgv addSubview:self.lineView_second];
    [self.lineView_second mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
        make.top.mas_equalTo(self.lineView_first.mas_bottom);
        make.width.mas_equalTo(1);
        make.bottom.mas_equalTo(self.lineView_fouth.mas_top);
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
        make.top.mas_equalTo(self.lineView_first.mas_bottom).mas_equalTo(75);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.lineView_second.mas_left);
    }];
    
    [self.bgv addSubview:self.statTimeLb];
    [self.statTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView_second.mas_right).mas_equalTo(8);
        make.top.mas_equalTo(self.lineView_thrid.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgv addSubview:self.endTimeLb];
    [self.endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.lineView_thrid.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgv addSubview:self.delBtn];
    [self.delBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.lineView_fouth.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
    }];

    [self.bgv addSubview:self.strtBtn];
    [self.strtBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.delBtn.mas_left).mas_equalTo(-25);
        make.top.mas_equalTo(self.lineView_fouth.mas_bottom);
        make.bottom.mas_equalTo(0);
        make.width.mas_equalTo(60);
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
        _lineView_first.backgroundColor = LineColor;
    }
    return _lineView_first;
}

- (UIView *)lineView_second {
    if (!_lineView_second) {
        _lineView_second = [UIView new];
        _lineView_second.backgroundColor = LineColor;
    }
    return _lineView_second;
}

- (UIView *)lineView_thrid {
    if (!_lineView_thrid) {
        _lineView_thrid = [UIView new];
        _lineView_thrid.backgroundColor = LineColor;
    }
    return _lineView_thrid;
}

- (UIView *)lineView_fouth {
    if (!_lineView_fouth) {
        _lineView_fouth = [UIView new];
        _lineView_fouth.backgroundColor = LineColor;
    }
    return _lineView_fouth;
}

- (UIImageView *)bgv {
    if (!_bgv) {
        _bgv = [UIImageView new];
        _bgv.backgroundColor = [UIColor grayColor];
        _bgv.layer.cornerRadius = 4;
        _bgv.layer.masksToBounds =YES;
        _bgv.layer.borderColor = LineColor.CGColor;
        _bgv.layer.borderWidth = 1.0f;
        _bgv.image = [self blur:[UIImage imageNamed:@"背景"]];
        
        _bgv.userInteractionEnabled = YES;
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
-(ToDoTitleAndIVView *)strtBtn {
    if (!_strtBtn) {
        _strtBtn = [[ToDoTitleAndIVView alloc] init];
        [_strtBtn setTitle:@"开始"];
        [_strtBtn setImg:@"start"];
        _strtBtn.userInteractionEnabled = YES;
        [_strtBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStartBtn)]];

    }
    return _strtBtn;
}

-(ToDoTitleAndIVView *)delBtn {
    if (!_delBtn) {
        _delBtn = [[ToDoTitleAndIVView alloc] init];
        [_delBtn setTitle:@"删除"];
        [_delBtn setImg:@"delete"];
        _delBtn.userInteractionEnabled = YES;
        [_delBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickDeleteBtn)]];
    }
    return _delBtn;
}
@end
