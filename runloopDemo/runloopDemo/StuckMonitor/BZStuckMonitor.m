//
//  BZStuckMonitor.m
//  runloopDemo
//
//  Created by brandon on 2020/6/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "BZStuckMonitor.h"

@interface BZStuckMonitor(){
    //声明runloop观察者
    CFRunLoopObserverRef runLoopObserver;
    //声明信号量
    dispatch_semaphore_t dispatchSemaphore;
    //runloop状态
    CFRunLoopActivity runLoopActivity;
}

@end

@implementation BZStuckMonitor

+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)startMonitor{
    //监测卡顿
    if (runLoopObserver) {
        return;
    }
    dispatchSemaphore = dispatch_semaphore_create(0); //Dispatch Semaphore保证同步
    //创建一个观察者
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,
                                              kCFRunLoopAllActivities,
                                              YES,
                                              0,
                                              &runLoopObserverCallBack,
                                              &context);
    //将观察者添加到主线程runloop的common模式下的观察中
    CFRunLoopAddObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    
    //创建子线程监控
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //子线程开启一个持续的loop用来进行监控
        while (YES) {
            long semaphoreWait = dispatch_semaphore_wait(self->dispatchSemaphore, dispatch_time(DISPATCH_TIME_NOW, 10*NSEC_PER_MSEC));
            //  semaphoreWait 的值不为 0， 说明线程被堵塞
            if (semaphoreWait != 0) {
                if (!self->runLoopObserver) {
                    self->dispatchSemaphore = 0;
                    self->runLoopActivity = 0;
                    return;
                }
                // BeforeSources和 AfterWaiting 这两个 runloop 状态的区间时间能够检测到是否卡顿
                if (self->runLoopActivity == kCFRunLoopBeforeSources || self->runLoopActivity == kCFRunLoopAfterWaiting) {
                    // 将堆栈信息上报服务器的代码放到这里
                    NSLog(@"卡顿了");
                } //end activity
            }// end semaphore wait
        }// end while
    });
}

- (void)endMonitor {
    if (!runLoopObserver) {
        return;
    }
    CFRunLoopRemoveObserver(CFRunLoopGetMain(), runLoopObserver, kCFRunLoopCommonModes);
    CFRelease(runLoopObserver);
    runLoopObserver = NULL;
}

//观察者回调事件
static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    BZStuckMonitor *lagMonitor = (__bridge BZStuckMonitor*)info;
    lagMonitor->runLoopActivity = activity;
    //获取信号量的值
    dispatch_semaphore_t semaphore = lagMonitor->dispatchSemaphore;
    //信号通知，dispatch_semaphore_signal使信号量加1
    dispatch_semaphore_signal(semaphore);
}

@end
