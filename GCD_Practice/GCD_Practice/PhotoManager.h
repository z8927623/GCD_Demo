//
//  PhotoManager.h
//  NSThread
//
//  Created by Wild Yaoyao on 14/11/9.
//  Copyright (c) 2014年 Yang Yao. All rights reserved.
//

#import <Foundation/Foundation.h>

// diapatch_barrier使用，在并发队列上扮演一个串行式的瓶颈
// 创建一个线程安全的NSMutableArray

@interface PhotoManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, strong) NSMutableArray *photosArray;

@property (nonatomic, strong) dispatch_queue_t concurrentQueue;

- (void)addPhoto:(NSString *)photoId;

- (NSArray *)photos;

@end
