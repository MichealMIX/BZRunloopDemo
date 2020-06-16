//
//  FPSMonitor.m
//  runloopDemo
//
//  Created by brandon on 2020/6/12.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "FPSMonitor.h"
#import <UIKit/UIKit.h>
@interface FPSMonitor()

@property(nonatomic,strong)CADisplayLink *displayLink;

@property(assign, nonatomic)CFTimeInterval lastTimestamp;

@property(assign, nonatomic)CFTimeInterval performTimes;

@end

@implementation FPSMonitor

+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setupDisplayLink];
    }
    return self;
}

- (void)setupDisplayLink{
    // 初始化CADisplayLink
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(fpsCount:)];
    // 把CADisplayLink对象加入runloop
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}


// 方法执行帧率和屏幕刷新率保持一致
- (void)fpsCount:(CADisplayLink *)displayLink {
    if (_lastTimestamp == 0) {
        _lastTimestamp = self.displayLink.timestamp;
    } else {
        _performTimes++;
        // 开始渲染时间与上次渲染时间差值
        NSTimeInterval useTime = self.displayLink.timestamp - _lastTimestamp;
        if (useTime < 1) return;
        _lastTimestamp = self.displayLink.timestamp;
        // fps 计算
        float fps = _performTimes / useTime;
        NSLog(@"%f",fps);
        _performTimes = 0;
    }
}

@end
