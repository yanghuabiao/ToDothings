//
//  TOSecondController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoSecondController.h"
#import "ToFirstDoListCell.h"
#import "GODDBHelper.h"
#import <Masonry.h>
@interface ToDoSecondController ()<UITableViewDelegate, UITableViewDataSource, ToFirstDoListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation ToDoSecondController

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
    NSArray *tempArr = [[GODDBHelper sharedHelper] god_queryWithType:ToDoThingsTypeIsDoing];

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

//点击结束
- (void)clickStartWithCell:(ToFirstDoListCell *)cell model:(ToDoMainModel *)model {
    model.type = ToDoThingsTypeIsDone;
    [[GODDBHelper sharedHelper] god_saveOrUpdate:model];
    [self.dataArr removeObject:model];
    [self.tableView deleteRowsAtIndexPaths:@[[self.tableView indexPathForCell:cell]] withRowAnimation:UITableViewRowAnimationFade];
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

@end
