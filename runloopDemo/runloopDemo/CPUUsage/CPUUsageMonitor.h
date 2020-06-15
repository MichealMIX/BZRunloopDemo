//
//  CPUUsageMonitor.h
//  runloopDemo
//
//  Created by brandon on 2020/6/15.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CPUUsageMonitor : NSObject

+ (instancetype)shareInstance;

- (integer_t)cpuUsage;

@end

NS_ASSUME_NONNULL_END
