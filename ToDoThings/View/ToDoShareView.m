//
//  ToDoShareView.m
//  ToDoThings
//
//  Created by Maker on 2019/4/17.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoShareView.h"
#import "GODDefine.h"
#import "ToDoTool.h"
#import <Masonry.h>
#import <WXApi.h>
#import <MFHUDManager.h>

#define whiteBgvWidth ScreenWidth
#define whiteBgvHeight 500

@interface ToDoShareView ()

@property (nonatomic, strong) UILabel *shareLb;
@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *tipsLb;
@property (nonatomic, strong) UIButton *weChatSessionBtn;
@property (nonatomic, strong) UIButton *wechatTimeLineBtn;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIView *bgWhiteView;
@property (nonatomic, strong) ToDoMainModel *model;

@end


@implementation ToDoShareView

- (instancetype)init {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        [self setupUI];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    
    
    
    [self addSubview:self.bgWhiteView];
    self.bgWhiteView.frame = CGRectMake(0, ScreenHeight, whiteBgvWidth, whiteBgvHeight + SafeAreaBottomHeight);
    
    [self.bgWhiteView addSubview:self.iconIV];
    [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(StatusBarHeight);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(330);
    }];
    
    [self addSubview:self.shareLb];
    [self.shareLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(self.bgWhiteView.mas_top).mas_equalTo(-20);
    }];
    
    
    [self.bgWhiteView addSubview:self.tipsLb];
    [self.tipsLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.iconIV.mas_bottom).mas_equalTo(10);
    }];
    
    [self.bgWhiteView addSubview:self.titleLb];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.tipsLb.mas_bottom).mas_equalTo(8);
    }];
    
    [self addSubview:self.wechatTimeLineBtn];
    [self.wechatTimeLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.top.mas_equalTo(self.bgWhiteView.mas_bottom).mas_equalTo(10);
    }];
    
    [self addSubview:self.weChatSessionBtn];
    [self.weChatSessionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.wechatTimeLineBtn);
        make.right.mas_equalTo(self.wechatTimeLineBtn.mas_left).mas_equalTo(-50);
    }];
    
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.wechatTimeLineBtn);
        make.right.mas_equalTo(self.wechatTimeLineBtn.mas_right).mas_equalTo(70);
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
        self.bgWhiteView.frame = CGRectMake(0, (ScreenHeight - whiteBgvHeight)/2.0, whiteBgvWidth, whiteBgvHeight);
    }];
    NSString *time = [NSString stringWithFormat:@"只用了\n%@", [ToDoTool dateTimeDifferenceWithStartTime:self.model.realStartTime endTime:self.model.realEndTime]];
    self.titleLb.text = [NSString stringWithFormat:@"我完成了《%@》\n%@", self.model.title, time];
    self.iconIV.image = [UIImage imageNamed:@"aaa_1"/**[NSString stringWithFormat:@"aaa_%u", arc4random()%6]*/];
}

-(void)dismissAndRemove {
    
    self.model = nil;
    
    [UIView animateWithDuration:0.25f animations:^{
        self.bgWhiteView.frame = CGRectMake(20, ScreenHeight, whiteBgvWidth, whiteBgvHeight);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)showWithModel:(ToDoMainModel *)model {
    self.model = model;
    [self show];
}

- (void)clickCancelBtn {
    [self dismissAndRemove];

}

- (void)clickSessionBtn {
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        UIImage *image = [self screenShotView:self.bgWhiteView];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = imageData;
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.mediaObject = imageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        [WXApi sendReq:req];
    }else {
        // 提示用户安装微信
        [MFHUDManager showError:@"请先安装微信"];
    }
    
}

- (void)clickTimeLineBtn {
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        
        UIImage *image = [self screenShotView:self.bgWhiteView];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        
        WXImageObject *imageObject = [WXImageObject object];
        imageObject.imageData = imageData;
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.mediaObject = imageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneTimeline;
        [WXApi sendReq:req];
    }else {
        // 提示用户安装微信
        [MFHUDManager showError:@"请先安装微信"];
    }
    
}

// 对指定视图进行截图
- (UIImage *)screenShotView:(UIView *)view
{
    UIImage *imageRet = nil;
    
    if (view)
    {
        if(&UIGraphicsBeginImageContextWithOptions)
        {
            UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
        }
        else
        {
            UIGraphicsBeginImageContext(view.frame.size);
        }
        
        //获取图像
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
        imageRet = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }else{
    }
    
    return imageRet;
}

- (UIButton *)weChatSessionBtn {
    if (!_weChatSessionBtn) {
        _weChatSessionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_weChatSessionBtn addTarget:self action:@selector(clickSessionBtn) forControlEvents:UIControlEventTouchUpInside];
        [_weChatSessionBtn setImage:[UIImage imageNamed:@"btn_show_wechat"] forState:UIControlStateNormal];
        [_weChatSessionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _weChatSessionBtn;
}

- (UIButton *)wechatTimeLineBtn {
    if (!_wechatTimeLineBtn) {
        _wechatTimeLineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_wechatTimeLineBtn addTarget:self action:@selector(clickTimeLineBtn) forControlEvents:UIControlEventTouchUpInside];
        [_wechatTimeLineBtn setImage:[UIImage imageNamed:@"btn_show_quan"] forState:UIControlStateNormal];
        [_wechatTimeLineBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _wechatTimeLineBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
        [_cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (UIView *)bgWhiteView {
    if (!_bgWhiteView) {
        _bgWhiteView = [[UIView alloc]init];
        _bgWhiteView.backgroundColor = [UIColor whiteColor];
        _bgWhiteView.layer.masksToBounds = YES;
    }
    return _bgWhiteView;
}

- (UIImageView *)iconIV {
    if (!_iconIV) {
        _iconIV = [[UIImageView alloc] init];
        _iconIV.contentMode = UIViewContentModeScaleAspectFill;
        _iconIV.layer.masksToBounds = YES;
        _iconIV.layer.cornerRadius = 4.0f;
    }
    return _iconIV;
}


- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18];
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.numberOfLines = 0;
        _titleLb.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLb;
}

- (UILabel *)tipsLb {
    if (!_tipsLb) {
        _tipsLb = [[UILabel alloc] init];
        _tipsLb.font = [UIFont fontWithName:@"PingFangSC-Light" size:16];
        _tipsLb.textColor = [UIColor blackColor];
        _tipsLb.textAlignment = NSTextAlignmentCenter;
        _tipsLb.text = @"追求卓越，坚持不懈";
    }
    return _tipsLb;
}

- (UILabel *)shareLb {
    if (!_shareLb) {
        _shareLb = [[UILabel alloc] init];
        _shareLb.font = [UIFont fontWithName:@"PingFangSC-Medium" size:20];
        _shareLb.textColor = [UIColor blackColor];
        _shareLb.text = @"分享";
    }
    return _shareLb;
}


@end
