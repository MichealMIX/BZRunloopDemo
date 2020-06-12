//
//  ThreadTestVC.m
//  runloopDemo
//
//  Created by brandon on 2020/6/9.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "ThreadTestVC.h"
#import "BZThread.h"
@interface ThreadTestVC ()

@end

@implementation ThreadTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Thread will delloc";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self threadTest];
}

- (void)initUI{
    UILabel *label_desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, iScreenW-40, 80)];
    label_desc.textColor = [UIColor blackColor];
    label_desc.numberOfLines = 0;
    label_desc.text = @"注意控制台输出，线程执行完毕便会销毁";
    [self.view addSubview:label_desc];
}


- (void)threadTest {
    BZThread *thread = [[BZThread alloc] initWithTarget:self selector:@selector(subThreadOpetion) object:nil];
    [thread start];
}

- (void)subThreadOpetion {
    @autoreleasepool {
        NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
    }
}

@end
