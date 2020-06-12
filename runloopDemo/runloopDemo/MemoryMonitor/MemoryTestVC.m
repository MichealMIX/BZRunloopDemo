//
//  MemoryTestVC.m
//  runloopDemo
//
//  Created by brandon on 2020/6/12.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "MemoryTestVC.h"
#import "BZMemoryMonitor.h"
@interface MemoryTestVC (){
    float usedMemory;
}

@property (nonatomic,strong)NSMutableArray *array;

@property (nonatomic,strong)UILabel *useLabel;

@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation MemoryTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MemoryTest";
    self.view.backgroundColor = [UIColor whiteColor];
    self.array = [NSMutableArray array];
    [self initUI];
    [self startMonitor];
    // Do any additional setup after loading the view.
}

- (void)initUI{
    UILabel *label_desc = [[UILabel alloc] initWithFrame:CGRectMake(20, 200, iScreenW-40, 80)];
    label_desc.textColor = [UIColor blackColor];
    [self.view addSubview:label_desc];
    _useLabel = label_desc;
}

- (void)startMonitor{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0*NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        //定时器需要执行的操作
        self->usedMemory = [[BZMemoryMonitor shareInstance] getMemoryUse];
        [weakSelf increaseMemory];
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            weakSelf.useLabel.text = [NSString stringWithFormat:@"使用内存：%f",self->usedMemory];
        });
       
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
}


- (void)increaseMemory{
    
    for (int i = 0; i < 1000; i++) {
        NSObject *obj = [[NSObject alloc] init];
        [self.array addObject:obj];
    }
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
