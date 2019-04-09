//
//  TODoFirstController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "TODoFirstController.h"
#import "ToFirstDoListCell.h"
#import <Masonry.h>
@interface TODoFirstController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation TODoFirstController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    
    ToDoMainModel *model = [ToDoMainModel new];
    model.title = @"约了个小姐姐";
    model.content = @"远上寒山石径斜，白云深处有人家，停车做爱枫林晚，s霜叶红于二月花";
    model.startTime = @"1554565604";
    model.endTime = @"1554997604";
    model.type = ToDoThingsTypeToDo;
    
    ToDoMainModel *model1 = [ToDoMainModel new];
    model1.title = @"打球";
    model1.content = @"分开辣就是六块腹肌氨基酚骄傲立刻就分开辣椒是否老卡机斯洛伐克奇偶去肥胖离开砥砺奋进按老规矩辣椒风口浪尖阿弗莱克";
    model1.startTime = @"1555084004";
    model1.endTime = @"1557676004";
    model1.type = ToDoThingsTypeToDo;
    model1.isOpenNoti = YES;
    
    [self.dataArr addObjectsFromArray:@[model, model1]];
    [self.tableView reloadData];
    
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ToFirstDoListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ToFirstDoListCell" forIndexPath:indexPath];
    cell.model = self.dataArr[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 170;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
