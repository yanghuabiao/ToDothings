//
//  ToDoThridController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoThridController.h"
#import "ToFirstDoListCell.h"
#import "GODDBHelper.h"
#import <Masonry.h>
#import "GODSettingViewController.h"
#import "ToDoDoneDetailView.h"

@interface ToDoThridController ()<UITableViewDelegate, UITableViewDataSource, ToFirstDoListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ToDoThridController

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
    NSArray *tempArr = [[GODDBHelper sharedHelper] god_queryWithType:ToDoThingsTypeIsDone];
    
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:tempArr];
    [self.tableView reloadData];
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}


- (void)clickDeleteWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model {
    [[GODDBHelper sharedHelper] god_delete:model.bg_id];
    [self.dataArr removeObject:model];
    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
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
    ToDoDoneDetailView *showView = [[ToDoDoneDetailView alloc] init];
    [showView showWithModel:model];
    
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

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    
//}

@end
