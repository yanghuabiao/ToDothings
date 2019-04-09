
//
//  ToDoEdtitView.m
//  ToDoThings
//
//  Created by Maker on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoEdtitView.h"
#import "GODDefine.h"
#import <Masonry.h>
#import "UIView+ZDD.h"
#import <UITextView+Placeholder/UITextView+Placeholder.h>

#define whiteBgvWidth ScreenWidth - 40
#define whiteBgvHeight ScreenHeight - 100

@interface ToDoEdtitView ()

@property (nonatomic, strong) UITextField *titleTf;
@property (nonatomic, strong) UITextView *contentTV;
@property (nonatomic, strong) UIView *lineView_first;
@property (nonatomic, strong) UILabel *notiLb;
@property (nonatomic, strong) UILabel *startTimeLb;
@property (nonatomic, strong) UILabel *endTimeLb;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *certainBtn;


@property (nonatomic, strong) UIView *bgWhiteView;
@property (nonatomic, strong) UIButton *masking;

@end


@implementation ToDoEdtitView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setupUI];
    }
    return self;
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
        make.bottom.mas_equalTo(-210);
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
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.notiLb.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgWhiteView addSubview:self.endTimeLb];
    [self.endTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.top.mas_equalTo(self.startTimeLb.mas_bottom).mas_equalTo(15);
    }];
    
    [self.bgWhiteView addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.bottom.mas_equalTo(-15);
    }];
    
    [self.bgWhiteView addSubview:self.certainBtn];
    [self.certainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-25);
        make.bottom.mas_equalTo(-15);
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
        self.bgWhiteView.frame = CGRectMake(20, 50, whiteBgvWidth, whiteBgvHeight);
    }];
    [self.titleTf becomeFirstResponder];
}


-(void)dismissAndRemove {
    [UIView animateWithDuration:0.25f animations:^{
        self.masking.alpha = 0.0f;
        self.bgWhiteView.frame = CGRectMake(20, ScreenHeight, whiteBgvWidth, whiteBgvHeight + SafeAreaBottomHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
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
        _endTimeLb.text = @"开始时间";
    }
    return _endTimeLb;
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
        [_masking addTarget:self action:@selector(dismissAndRemove) forControlEvents:UIControlEventTouchUpInside];
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
