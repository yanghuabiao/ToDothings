//
//  GODSettingViewController.m
//  ToDoThings
//
//  Created by 张冬冬 on 2019/4/9.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "GODSettingViewController.h"
#import <StoreKit/StoreKit.h>
#import <Social/Social.h>
#import <MFHUDManager/MFHUDManager.h>
#import "GODFaceIDTableViewCell.h"
#import "GODNormalTableViewCell.h"
#import "JnPasswordView.h"
#import "GODDBHelper.h"

@interface GODSettingViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation GODSettingViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UIImage *image = [[UIImage imageNamed:@"webview_btn_close_normal_27x27_"] imageWithRenderingMode:(UIImageRenderingModeAlwaysTemplate)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(back)];
}

- (void)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        GODFaceIDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"a"];
        if (!cell) {
            cell = [[GODFaceIDTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"a"];
        }
        cell.titleLabel.text = @"密码";
        cell.faceIdSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"faceIdOn"];
        [cell.faceIdSwitch addTarget:self action:@selector(switchOn:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.leftImageView.image = [UIImage imageNamed:@"function_icon_privacy_43x43_"];
        return cell;
    }else if (indexPath.row == 1) {
        GODNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"b"];
        if (!cell) {
            cell = [[GODNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"b"];
        }
        cell.titleLabel.text = @"清空";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.leftImageView.image = [UIImage imageNamed:@"function_icon_group_43x43_"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 2) {
        GODNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"c"];
        if (!cell) {
            cell = [[GODNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"c"];
        }
        cell.titleLabel.text = @"评分";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.leftImageView.image = [UIImage imageNamed:@"function_icon_sticker_43x43_"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        GODNormalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"d"];
        if (!cell) {
            cell = [[GODNormalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"d"];
        }
        cell.titleLabel.text = @"反馈";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.leftImageView.image = [UIImage imageNamed:@"function_icon_invite_mail_43x43_"];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)switchOn:(UISwitch *)sender {
    BOOL on = [[NSUserDefaults standardUserDefaults] boolForKey:@"faceIdOn"];
    JnPasswordView *pwdView = [JnPasswordView sharedInstance];
    if (on) {
        [pwdView showPasswordViewWithInputPwd:^(NSString *pwd) {
            
        } cancel:^{
            [sender setOn:!sender.isOn animated:YES];
             [pwdView dismissPasswordView];
        } certain:^{
            NSString *str = [[NSUserDefaults standardUserDefaults] stringForKey:@"faceId"];
            if ([pwdView.textField.text isEqualToString:str]) {
                [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"faceIdOn"];
                [MFHUDManager showSuccess:@"密码功能已关闭"];
            }else {
                [MFHUDManager showError:@"密码输入错误，请重试！"];
                [sender setOn:!sender.isOn animated:YES];
            }
            [pwdView dismissPasswordView];
        }];
    }else {
        [[JnPasswordView sharedInstance] showPasswordViewWithInputPwd:^(NSString *pwd) {
            
        } cancel:^{
            [sender setOn:!sender.isOn animated:YES];
            [pwdView dismissPasswordView];
        } certain:^{
            if (pwdView.textField.text && pwdView.textField.text.length) {
                [[NSUserDefaults standardUserDefaults] setObject:pwdView.textField.text forKey:@"faceId"];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"faceIdOn"];
                [MFHUDManager showSuccess:@"密码功能已开启"];
                [pwdView dismissPasswordView];
            }else {
                [MFHUDManager showError:@"密码位数错误，请重试！"];
            }
        }];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.row) {
        return;
    }else if (indexPath.row == 1) {
        [MFHUDManager showLoading:@"正在清空..."];
        [[GODDBHelper sharedHelper] god_clear];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MFHUDManager showSuccess:@"清空数据成功!"];
        });
    }else if (indexPath.row == 2) {
        if([SKStoreReviewController respondsToSelector:@selector(requestReview)]) {
            [[UIApplication sharedApplication].keyWindow endEditing:YES];
            [SKStoreReviewController requestReview];
        }
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"请输入反馈内容" preferredStyle:(UIAlertControllerStyleAlert)];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入反馈内容";
        }];
        __weak __typeof(alert)weakAlert = alert;
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
        UIAlertAction *a2 = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            __strong __typeof(weakAlert)strongAlert = weakAlert;
            NSString *prompt = strongAlert.textFields[0].text;
            if (prompt && prompt.length) {
                [MFHUDManager showLoading:@"提交中..."];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [MFHUDManager showSuccess:@"反馈成功！"];
                });
            }else {
                [MFHUDManager showError:@"反馈内容不能为空！"];
            }
        }];
        [alert addAction:action1];
        [alert addAction:a2];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
@end
