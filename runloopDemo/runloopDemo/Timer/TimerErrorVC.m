//
//  TimerErrorVC.m
//  runloopDemo
//
//  Created by brandon on 2020/6/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "TimerErrorVC.h"

@interface TimerErrorVC ()

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)NSInteger count;

@end

@implementation TimerErrorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Timer error when scroll";
    self.view.backgroundColor = [UIColor whiteColor];
    self.count = 0;
    [self initUI];
    [self setupTimer];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, kNavBarAndStatusBarHeight, iScreenW-40, 50)];
    self.countLabel.text = @"计时";
    [self.view addSubview:self.countLabel];
    
    UIScrollView *mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight+100, iScreenW, iScreenH-(kNavBarAndStatusBarHeight+kBottomSafeHeight)-100)];
    mainScroll.backgroundColor = [UIColor grayColor];
    mainScroll.contentSize = CGSizeMake(iScreenW, 1000);
    [self.view addSubview:mainScroll];
}

- (void)countAdd{
    self.countLabel.text = [NSString stringWithFormat:@"计时：%ld",(long)self.count++];
}

- (void)setupTimer{
    [self invalidateTimer];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countAdd) userInfo:nil repeats:YES];
    _timer = timer;
    //如果这句代码注释掉滑动时计时器将不正常
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc{
    [self invalidateTimer];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
