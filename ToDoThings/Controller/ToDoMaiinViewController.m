//
//  ToDoMaiinViewController.m
//  ToDoThings
//
//  Created by Maker on 2019/4/8.
//  Copyright © 2019 MakerYang.com. All rights reserved.
//

#import "ToDoMaiinViewController.h"
#import "ToDoSecondController.h"
#import "TODoFirstController.h"
#import "ToDoThridController.h"
#import "ToDoSecondController.h"

#import "GODDefine.h"
#import "UIView+ZDD.h"
#import "UIColor+CustomColors.h"

@interface ToDoMaiinViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segment;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) ToDoThridController *thridVC;
@property (nonatomic, strong) ToDoSecondController *secondVC;
@property (nonatomic, strong) TODoFirstController *firstVC;
@end

@implementation ToDoMaiinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    NSArray *array = [NSArray arrayWithObjects:@"待开始", @"进行中", @"已完成", nil];
    self.segment = [[UISegmentedControl alloc]initWithItems:array];
    self.segment.frame = CGRectMake(10, STATUSBARHEIGHT + 20, self.view.frame.size.width-20, 30);
    self.segment.apportionsSegmentWidthsByContent = YES;
    self.segment.tintColor = [UIColor customBlueColor];
    [self.segment addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segment];
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.firstVC.view];
    self.firstVC.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
    
    [self.scrollView addSubview:self.secondVC.view];
    self.secondVC.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);
    
    [self.scrollView addSubview:self.thridVC.view];
    self.thridVC.view.frame = CGRectMake(ScreenWidth * 2.0, 0, ScreenWidth, self.scrollView.height);
    
    self.segment.selectedSegmentIndex = 0;
}

-(void)change:(UISegmentedControl *)sender{

    [self.scrollView setContentOffset:CGPointMake(ScreenWidth * sender.selectedSegmentIndex, 0) animated:YES];
    [UIView animateWithDuration:0.5 animations:^{
        if (!sender.selectedSegmentIndex) {
            sender.tintColor = [UIColor customBlueColor];
        }else if (sender.selectedSegmentIndex == 1) {
            sender.tintColor = [UIColor customRedColor];
        }else {
            sender.tintColor = [UIColor customGreenColor];
        }
    }];
}


- (void)pageViewSelectdIndex:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    self.segment.selectedSegmentIndex = scrollView.contentOffset.x/ScreenWidth;
    [UIView animateWithDuration:0.5 animations:^{
        if (!self.segment.selectedSegmentIndex) {
            self.segment.tintColor = [UIColor customBlueColor];
        }else if (self.segment.selectedSegmentIndex == 1) {
            self.segment.tintColor = [UIColor customRedColor];
        }else {
            self.segment.tintColor = [UIColor customGreenColor];
        }
    }];
}


- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.frame = CGRectMake(0, StatusBarHeight + 65, ScreenWidth, ScreenHeight - StatusBarHeight - 65);
        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, ScreenHeight - SafeTabBarHeight - StatusBarHeight - 44);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

- (TODoFirstController *)firstVC {
    if (!_firstVC) {
        _firstVC = [TODoFirstController new];
        [self addChildViewController:_firstVC];
    }
    return _firstVC;
}

- (ToDoSecondController *)secondVC {
    if (!_secondVC) {
        _secondVC = [ToDoSecondController new];
        [self addChildViewController:_secondVC];
    }
    return _secondVC;
}

- (ToDoThridController *)thridVC {
    if (!_thridVC) {
        _thridVC = [ToDoThridController new];
        [self addChildViewController:_thridVC];
    }
    return _thridVC;
}

@end
