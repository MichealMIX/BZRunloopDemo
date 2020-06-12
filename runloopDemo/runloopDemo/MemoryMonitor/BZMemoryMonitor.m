//
//  BZMemoryMonitor.m
//  runloopDemo
//
//  Created by brandon on 2020/6/12.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import "BZMemoryMonitor.h"
#import <mach/mach.h>
@implementation BZMemoryMonitor

+ (instancetype)shareInstance{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (float)getMemoryUse{
    //TASK_VM_INFO中存储物理内存使用信息
    int64_t memoryUsageInByte = 0;
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count);
    if (kernReturn != KERN_SUCCESS) { return NSNotFound; }
    memoryUsageInByte = (int64_t) vmInfo.phys_footprint;
    return memoryUsageInByte/1024.0/1024.0;
}

@end
