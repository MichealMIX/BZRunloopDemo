//
//  BZMemoryMonitor.h
//  runloopDemo
//
//  Created by brandon on 2020/6/12.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BZMemoryMonitor : NSObject

+ (instancetype)shareInstance;

- (float)getMemoryUse;

@end

NS_ASSUME_NONNULL_END
