//
//  StuckTestVC.m
//  runloopDemo
//
//  Created by brandon on 2020/6/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "StuckTestVC.h"
#import "BZStuckMonitor.h"
#import "FPSMonitor.h"
#import "CPUUsageMonitor.h"
@interface StuckTestVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView *cv;

@property(nonatomic,strong)dispatch_source_t timer;

@end

@implementation StuckTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [[BZStuckMonitor shareInstance] startMonitor];
//    [[FPSMonitor shareInstance] setFpsCB:^(float fps) {
////        NSLog(@"%f",fps);
//    }];
    [self initUI];
    [self getCpuUsage];
    // Do any additional setup after loading the view.
}

- (void)getCpuUsage{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //创建一个定时器（dispatch_source_t本质上还是一个OC对象）
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置定时器的各种属性
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0*NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(2.0*NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    
    //设置回调
    __weak typeof(self) weakSelf = self;
    dispatch_source_set_event_handler(self.timer, ^{
        //定时器需要执行的操作
        NSLog(@"%d",[[CPUUsageMonitor shareInstance] cpuUsage]);
       
    });
    //启动定时器（默认是暂停）
    dispatch_resume(self.timer);
}

- (void)initUI{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    //针对上下的间距
    flowLayout.minimumLineSpacing = 10;
    //针对左右的间距
    flowLayout.minimumInteritemSpacing = 5;
    //滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    UICollectionView *collectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavBarAndStatusBarHeight, iScreenW, iScreenH-(kNavBarAndStatusBarHeight+kBottomSafeHeight)) collectionViewLayout:flowLayout];
    //不显示横纵滑动条
    collectionV.backgroundColor = [UIColor whiteColor];
    collectionV.showsHorizontalScrollIndicator = NO;
    collectionV.showsVerticalScrollIndicator = NO;
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"main"];
    collectionV.dataSource = self;
    collectionV.delegate = self;
    [self.view addSubview:collectionV];
    _cv = collectionV;
}

#pragma mark - UICollection delegate

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
        
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"main" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
    imageV.layer.cornerRadius = 10;
    imageV.layer.masksToBounds = YES;
    imageV.layer.shadowColor = [UIColor greenColor].CGColor;//阴影颜色
    imageV.layer.shadowOffset = CGSizeMake(0, 0);//偏移距离
    imageV.layer.shadowOpacity = 0.5;//不透明度
    imageV.layer.shadowRadius = 10.0;//半径
    [cell addSubview:imageV];
    imageV.image = [UIImage imageNamed:@"thumb-1920-944326"];
    cell.layer.cornerRadius = 10;
    return cell;

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(100, 150);
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 100;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 20;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}

@end
