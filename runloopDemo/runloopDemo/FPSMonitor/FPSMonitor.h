//
//  FPSMonitor.h
//  runloopDemo
//
//  Created by brandon on 2020/6/12.
//  Copyright © 2020 brandon_zheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^fpsCallBack)(float fps);

@interface FPSMonitor : NSObject

+ (instancetype)shareInstance;

@property(nonatomic,copy)fpsCallBack fpsCB;

@end

NS_ASSUME_NONNULL_END
