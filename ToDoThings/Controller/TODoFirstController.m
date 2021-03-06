//
//  TODoFirstController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "TODoFirstController.h"
#import "ToFirstDoListCell.h"
#import "GODDBHelper.h"
#import <Masonry.h>
#import "ToDoEdtitView.h"
#import "GODDefine.h"
#import "ToDoTool.h"
#import "GODSettingViewController.h"

@interface TODoFirstController ()<UITableViewDelegate, UITableViewDataSource, ToFirstDoListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) ToDoEdtitView *editView;
@property (nonatomic, strong) UIButton *writeBtn;
@property (nonatomic, strong) UIButton *settingBtn;

@end

@implementation TODoFirstController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self reloadList];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadList) name:@"reloadList" object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)reloadList {
    NSArray *tempArr = [[GODDBHelper sharedHelper] god_queryWithType:ToDoThingsTypeToDo];
    if (tempArr.count == 0) {
        ToDoMainModel *model = [ToDoMainModel new];
        model.type = ToDoThingsTypeToDo;
        model.title = @"如何使用";
        model.content = @"1.点击右下角按钮新建事项\n2.填写事项标题，内容，选择开始时间，完成时间，是否需要提醒，然后点击对号\n3.点击列表的开始/完成，分别可以对事项进行开始和已完成的操作，删除可以删除事项\n4.谢谢您的使用";
        model.startTime = [ToDoTool getCurrentTimestamp];
        model.endTime = [ToDoTool getCurrentTimestamp];
        tempArr = @[model];
    }
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:tempArr];
    [self.tableView reloadData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    [self.view addSubview:self.writeBtn];
    [self.writeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.right.mas_equalTo(-20.0f);
        make.bottom.mas_equalTo(-(SafeAreaBottomHeight + 100.0f));
    }];
    
    [self.view addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.right.mas_equalTo(-20.0f);
        make.bottom.mas_equalTo(-(SafeAreaBottomHeight + 30.0f));
    }];
}

- (void)clickwriteBtn {
    [self.editView show];
}

- (void)clickEditWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model {
    [self.editView showWithModel:model];
}
//点击开始
- (void)clickStartWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model {
    model.type = ToDoThingsTypeIsDoing;
    [[GODDBHelper sharedHelper] god_saveOrUpdate:model];
    [self.dataArr removeObject:model];
    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)clickDeleteWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model {
    
    [[GODDBHelper sharedHelper] god_delete:model.bg_id];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToFirstDoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToFirstDoListCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoMainModel *model = self.dataArr[indexPath.row];
    if (model.isOpenCell) {
        return 200;
    }
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ToDoMainModel *model = self.dataArr[indexPath.row];
    model.isOpenCell = !model.isOpenCell;
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}



- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.estimatedRowHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:ToFirstDoListCell.class forCellReuseIdentifier:@"ToFirstDoListCell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (ToDoEdtitView *)editView {
    if (!_editView) {
        _editView = [[ToDoEdtitView alloc] init];
    }
    return _editView;
}

-(UIButton *)writeBtn {
    if (!_writeBtn) {
        _writeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _writeBtn.backgroundColor = [UIColor whiteColor];
        _writeBtn.layer.cornerRadius = 30;
        _writeBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _writeBtn.layer.shadowOffset = CGSizeMake(.0f, 1.0f);
        _writeBtn.layer.shadowOpacity = .12f;
        _writeBtn.layer.shadowRadius = 4.0f;
        [_writeBtn setImage:[UIImage imageNamed:@"btn_postings"] forState:UIControlStateNormal];
        [_writeBtn addTarget:self action:@selector(clickwriteBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _writeBtn;
}
-(UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _settingBtn.backgroundColor = [UIColor whiteColor];
        _settingBtn.layer.cornerRadius = 30;
        _settingBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _settingBtn.layer.shadowOffset = CGSizeMake(.0f, 1.0f);
        _settingBtn.layer.shadowOpacity = .12f;
        _settingBtn.layer.shadowRadius = 4.0f;
        _settingBtn.tintColor = [UIColor blackColor];
        [_settingBtn setImage:[UIImage imageNamed:@"addressBook_setting"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(clicksettingBtn) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _settingBtn;
}

- (void)clicksettingBtn {
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[GODSettingViewController new]];
    [self presentViewController:navi animated:YES completion:nil];
}
@end
