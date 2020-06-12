//
//  BZStuckMonitor.h
//  runloopDemo
//
//  Created by brandon on 2020/6/10.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BZStuckMonitor : NSObject

+ (instancetype)shareInstance;

- (void)startMonitor;

@end

NS_ASSUME_NONNULL_END
