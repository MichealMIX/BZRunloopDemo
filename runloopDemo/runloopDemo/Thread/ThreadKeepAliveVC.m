//
//  ThreadKeepAliveVC.m
//  runloopDemo
//
//  Created by brandon on 2020/6/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "ThreadKeepAliveVC.h"
#import "BZThread.h"
@interface ThreadKeepAliveVC ()

@property(nonatomic,strong)BZThread *subThread;

@end

@implementation ThreadKeepAliveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Thread always alive";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
    [self threadTest];
    
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UILabel *label_desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, iScreenW-40, 80)];
    label_desc.textColor = [UIColor blackColor];
    label_desc.numberOfLines = 0;
    label_desc.text = @"注意控制台输出，线程执行完毕不会销毁，点击视图再次执行依旧是之前线程";
    [self.view addSubview:label_desc];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self performSelector:@selector(subThreadOpetion) onThread:self.subThread withObject:nil waitUntilDone:NO];
}

- (void)threadTest {
    BZThread *thread = [[BZThread alloc] initWithTarget:self selector:@selector(subThreadEntryPoint) object:nil];
    [thread setName:@"BZThread"];
    [thread start];
    self.subThread = thread;
}

- (void)subThreadEntryPoint {
    @autoreleasepool {
        NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
        [runLoop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        // NSLog(@"runLoop--%@", runLoop);
        NSLog(@"启动RunLoop前--%@",runLoop.currentMode);
        [runLoop run];
    }
}

- (void)subThreadOpetion {
    @autoreleasepool {
        NSLog(@"%@----子线程任务开始",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3.0];
        NSLog(@"%@----子线程任务结束",[NSThread currentThread]);
    }
}

@end
