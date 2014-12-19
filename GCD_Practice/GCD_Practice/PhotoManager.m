//
//  PhotoManager.m
//  NSThread
//
//  Created by Wild Yaoyao on 14/11/9.
//  Copyright (c) 2014年 Yang Yao. All rights reserved.
//

#import "PhotoManager.h"

@implementation PhotoManager

//// 不安全
//+ (instancetype)sharedManager
//{
//    static PhotoManager *sharedPhotoManager = nil;
//    
//    if (!sharedPhotoManager) {
//        
//        [NSThread sleepForTimeInterval:2];
//        
//        sharedPhotoManager = [[PhotoManager alloc] init];
//        
//        NSLog(@"Singleton has memory address at: %@", sharedPhotoManager);
//        
////        [NSThread sleepForTimeInterval:2];
//        
//    }
//    
//    return sharedPhotoManager;
//}

//// 1
//+ (instancetype)sharedManager
//{
//    static PhotoManager *sharedPhotoManager = nil;
//    
//    @synchronized(self) {   // 相当于lock，unlock
//        
//        if (!sharedPhotoManager) {
//        
//            sharedPhotoManager = [[PhotoManager alloc] init];
//            
//            NSLog(@"Singleton has memory address at: %@", sharedPhotoManager);
//            
//            sharedPhotoManager->_photosArray = [NSMutableArray array];
//            sharedPhotoManager->_concurrentQueue = dispatch_queue_create("com.photoQueue", DISPATCH_QUEUE_CONCURRENT);
//        }
//    }
//    
//    return sharedPhotoManager;
//}

// 2
+ (instancetype)sharedManager
{
    static PhotoManager *sharedPhotoManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedPhotoManager = [[PhotoManager alloc] init];
        
        NSLog(@"Singleton has memory address at: %@", sharedPhotoManager);
        
        sharedPhotoManager->_photosArray = [NSMutableArray array];
        // 创建一个并发队列
        sharedPhotoManager->_concurrentQueue = dispatch_queue_create("com.photoQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return sharedPhotoManager;
}

- (void)addPhoto:(NSString *)photoId
{
    if (photoId) {
        // 创建读写者锁
        dispatch_barrier_async(self.concurrentQueue, ^{
            [_photosArray addObject:photoId];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"do other thing");
            });
        });
    }
}

- (NSArray *)photos
{
    __block NSArray *array;
    // 同步获取照片，必须等add操作完成之后再获取
    dispatch_sync(self.concurrentQueue, ^{
        array = [NSArray arrayWithArray:_photosArray];
    });
    
    return array;
}

@end
