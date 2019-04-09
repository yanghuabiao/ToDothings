
//
//  ToDoEdtitView.m
//  ToDoThings
//
//  Created by Maker on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoEdtitView.h"
#import "GODDefine.h"
#import "ToDoTool.H"
#import <Masonry.h>
#import "UIView+ZDD.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>
#import <BRPickerView.h>
#import "GODDBHelper.h"


#define whiteBgvWidth ScreenWidth - 40
#define whiteBgvHeight 500

@interface ToDoEdtitView ()

@property (nonatomic, strong) UITextField *titleTf;
@property (nonatomic, strong) UITextView *contentTV;
@property (nonatomic, strong) UIView *lineView_first;
@property (nonatomic, strong) UILabel *notiLb;
@property (nonatomic, strong) UILabel *startTimeLb;
@property (nonatomic, strong) UILabel *endTimeLb;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *certainBtn;

@property (nonatomic, strong) UILabel *firstTimeLb;
@property (nonatomic, strong) UILabel *secondTimeLb;

@property (nonatomic, strong) UIView *bgWhiteView;
@property (nonatomic, strong) UIButton *masking;

@property (nonatomic, strong) ToDoMainModel *model;

@end


@implementation ToDoEdtitView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setupUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.contentTV resignFirstResponder];
    [self.titleTf resignFirstResponder];
}

- (void)setupUI {
    [self addSubview:self.masking];
    [self.masking mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self addSubview:self.bgWhiteView];
    self.bgWhiteView.frame = CGRectMake(20, ScreenHeight, whiteBgvWidth, whiteBgvHeight + SafeAreaBottomHeight);

    
    [self.bgWhiteView addSubview:self.titleTf];
    [self.titleTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
    }];
    
    [self.bgWhiteView addSubview:self.lineView_first];
    [self.lineView_first mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.titleTf.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(1);
    }];
    
    [self.bgWhiteView addSubview:self.contentTV];
    [self.contentTV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.lineView_first.mas_bottom).mas_equalTo(10);
        make.height.mas_equalTo(200);
    }];
    
    [self.bgWhiteView addSubview:self.notiLb];
    [self.notiLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.contentTV.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgWhiteView addSubview:self.startTimeLb];
    [self.startTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(self.notiLb.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgWhiteView addSubview:self.endTimeLb];
    [self.endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(self.startTimeLb.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgWhiteView addSubview:self.firstTimeLb];
    [self.firstTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.startTimeLb.mas_right);
        make.centerY.mas_equalTo(self.startTimeLb);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(25);

    }];
    
    [self.bgWhiteView addSubview:self.secondTimeLb];
    [self.secondTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.endTimeLb.mas_right);
        make.centerY.mas_equalTo(self.endTimeLb);
        make.width.mas_equalTo(140);
        make.height.mas_equalTo(25);
    }];
    
    [self.bgWhiteView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(50);
        make.width.height.mas_equalTo(50);
        make.top.mas_equalTo(self.endTimeLb.mas_bottom).mas_equalTo(60);
    }];
    
    [self.bgWhiteView addSubview:self.certainBtn];
    [self.certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-50);
        make.width.height.mas_equalTo(50);
        make.top.mas_equalTo(self.endTimeLb.mas_bottom).mas_equalTo(60);
    }];
    
}

/** 展示view */
-(void)show
{
    //添加到window
    if (![[[[UIApplication sharedApplication] delegate] window].subviews containsObject:self]) {
        [[[[UIApplication sharedApplication] delegate] window] addSubview:self];
    }
    [UIView animateWithDuration:0.25f animations:^{
        self.masking.alpha = 0.5;
        self.bgWhiteView.frame = CGRectMake(20, (ScreenHeight - whiteBgvHeight)/2.0, whiteBgvWidth, whiteBgvHeight);
    }];
    [self.titleTf becomeFirstResponder];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-MM-dd HH:mm"];
    if (self.model) {
        self.titleTf.text = self.model.title;
        self.contentTV.text = self.model.content;
        self.firstTimeLb.text = self.model.startTime;
        self.secondTimeLb.text = self.model.endTime;
    }else {
        self.model = [[ToDoMainModel alloc] init];
        self.model.type = ToDoThingsTypeToDo;
        self.firstTimeLb.text = [format stringFromDate:[NSDate br_setHour:0 minute:5]];
        self.secondTimeLb.text = [format stringFromDate:[NSDate br_setHour:0 minute:10]];
    }
}

- (void)showWithModel:(ToDoMainModel *)model {
    self.model = model;
    [self show];
}

- (void)clickMasking {
    [self.contentTV resignFirstResponder];
    [self.titleTf resignFirstResponder];
}

- (void)clickCancenBtn {
    [self dismissAndRemove];
}

- (void)clickCertainBtn {
    
    self.model.title = self.titleTf.text;
    self.model.content = self.contentTV.text;
    self.model.startTime = self.firstTimeLb.text;
    self.model.endTime = self.secondTimeLb.text;
    [[GODDBHelper sharedHelper] god_saveOrUpdate:self.model];
    [self dismissAndRemove];
}

-(void)dismissAndRemove {
    
    self.model = nil;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.masking.alpha = 0.0f;
        self.bgWhiteView.frame = CGRectMake(20, ScreenHeight, whiteBgvWidth, whiteBgvHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}


- (void)clickStartTime {
    __weak typeof(self)weakSelf = self;
    NSDate *minDate = [NSDate date];
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 365 * 24 * 3600];
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:BRDatePickerModeYMDHM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        weakSelf.firstTimeLb.text = selectValue;
    } cancelBlock:^{
    }];
    
}

- (void)clickEndTime {
    __weak typeof(self)weakSelf = self;
    NSDate *minDate = [NSDate date];
    NSDate *maxDate = [NSDate dateWithTimeIntervalSinceNow:10 * 365 * 24 * 3600];
    [BRDatePickerView showDatePickerWithTitle:@"开始时间" dateType:BRDatePickerModeYMDHM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
        weakSelf.secondTimeLb.text = selectValue;
    } cancelBlock:^{
    }];
}

- (UILabel *)notiLb {
    if (!_notiLb) {
        _notiLb = [[UILabel alloc] init];
        _notiLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _notiLb.text = @"提醒";
    }
    return _notiLb;
}

- (UILabel *)startTimeLb {
    if (!_startTimeLb) {
        _startTimeLb = [[UILabel alloc] init];
        _startTimeLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _startTimeLb.text = @"开始时间";
    }
    return _startTimeLb;
}

- (UILabel *)endTimeLb {
    if (!_endTimeLb) {
        _endTimeLb = [[UILabel alloc] init];
        _endTimeLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
        _endTimeLb.text = @"完成时间";
    }
    return _endTimeLb;
}

- (UILabel *)firstTimeLb {
    if (!_firstTimeLb) {
        _firstTimeLb = [[UILabel alloc] init];
        _firstTimeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _firstTimeLb.textColor = [UIColor blackColor];
        _firstTimeLb.layer.cornerRadius = 4;
        _firstTimeLb.layer.masksToBounds = YES;
        _firstTimeLb.layer.borderWidth = 1.0f;
        _firstTimeLb.textAlignment = NSTextAlignmentCenter;
        _firstTimeLb.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
        _firstTimeLb.userInteractionEnabled = YES;
        [_firstTimeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickStartTime)]];
    }
    return _firstTimeLb;
}

- (UILabel *)secondTimeLb {
    if (!_secondTimeLb) {
        _secondTimeLb = [[UILabel alloc] init];
        _secondTimeLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        _secondTimeLb.textColor = [UIColor blackColor];
        _secondTimeLb.layer.cornerRadius = 4;
        _secondTimeLb.layer.masksToBounds = YES;
        _secondTimeLb.layer.borderWidth = 1.0f;
        _secondTimeLb.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:0.8].CGColor;
        _secondTimeLb.textAlignment = NSTextAlignmentCenter;
        _secondTimeLb.userInteractionEnabled = YES;
        [_secondTimeLb addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickEndTime)]];
    }
    return _secondTimeLb;
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(clickCancenBtn) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

-(UIButton *)certainBtn {
    if (!_certainBtn) {
        _certainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_certainBtn addTarget:self action:@selector(clickCertainBtn) forControlEvents:UIControlEventTouchUpInside];
        [_certainBtn setImage:[UIImage imageNamed:@"certain"] forState:UIControlStateNormal];
        [_certainBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _certainBtn;
}

- (UITextField *)titleTf {
    if (!_titleTf) {
        _titleTf = [[UITextField alloc] init];
        _titleTf.placeholder = @"新事项";
        _titleTf.textAlignment = NSTextAlignmentCenter;
        _titleTf.font = [UIFont systemFontOfSize:18];
    }
    return _titleTf;
}

- (UITextView *)contentTV {
    if (!_contentTV) {
        _contentTV = [[UITextView alloc] init];
        _contentTV.placeholder = @"请输入内容";
        _contentTV.font = [UIFont fontWithName:@"PingFangSC-Light" size:15];
        _contentTV.placeholderColor = [UIColor grayColor];
    }
    return _contentTV;
}

-(UIButton *)masking {
    if (!_masking) {
        _masking = [UIButton buttonWithType:UIButtonTypeCustom];
        [_masking addTarget:self action:@selector(clickMasking) forControlEvents:UIControlEventTouchUpInside];
        [_masking setBackgroundColor:[UIColor blackColor]];
        [_masking setAlpha:0.0f];
    }
    return _masking;
}

-(UIView *)bgWhiteView {
    if (!_bgWhiteView) {
        _bgWhiteView = [[UIView alloc]init];
        _bgWhiteView.backgroundColor = [UIColor whiteColor];
        _bgWhiteView.layer.masksToBounds = YES;
    }
    return _bgWhiteView;
}

- (UIView *)lineView_first {
    if (!_lineView_first) {
        _lineView_first = [UIView new];
        _lineView_first.backgroundColor = [UIColor blackColor];
        _lineView_first.alpha = 0.5;
    }
    return _lineView_first;
}
@end
