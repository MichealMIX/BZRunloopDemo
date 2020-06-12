//
//  ViewController.m
//  runloopDemo
//
//  Created by brandon on 2020/6/9.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "ViewController.h"
#import "ThreadTestVC.h"
#import "ThreadKeepAliveVC.h"
#import "TimerErrorVC.h"
#import "StuckTestVC.h"
#import "MemoryTestVC.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tv;

@property(nonatomic,copy)NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RunLoop";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)initUI{
    self.tv = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, iScreenW, iScreenH-(kNavBarAndStatusBarHeight+kBottomSafeHeight)) style:UITableViewStylePlain];
    self.tv.dataSource = self;
    self.tv.delegate = self;
    [self.tv registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tv];
}

#pragma mark - UITableViewDelegate&UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        ThreadTestVC *vc = [[ThreadTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        ThreadKeepAliveVC *vc = [[ThreadKeepAliveVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        TimerErrorVC *vc = [[TimerErrorVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        StuckTestVC *vc = [[StuckTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        MemoryTestVC *vc = [[MemoryTestVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter&setter

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"Thread will delloc",@"Thread always alive",@"Timer error when scroll",@"View stuck",@"Memory monitor"];
    }
    return _dataArray;
}

@end
