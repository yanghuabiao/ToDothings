//
//  ToDoThridController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoThridController.h"
#import "GODSettingViewController.h"
@interface ToDoThridController ()

@end

@implementation ToDoThridController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:[GODSettingViewController new]];
    [self presentViewController:navi animated:YES completion:nil];
}

@end
