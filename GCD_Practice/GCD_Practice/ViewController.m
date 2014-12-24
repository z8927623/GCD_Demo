//
//  ViewController.m
//  GCD_Practice
//
//  Created by wildyao on 14/12/19.
//  Copyright (c) 2014年 Wild Yaoyao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // dispatch_get_global_queue使用 ------------------------------
    // 第二个参数总是为0
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"dispatch_get_global_queue");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"global queue finished");
//        });
//    });
    
    
    // dispatch_queue_create使用 ------------------------------
    
//    dispatch_async(dispatch_queue_create("com.myQueue", DISPATCH_QUEUE_CONCURRENT), ^{
//        NSLog(@"dispatch_get_my_queue");
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"my queue finished");
//        });
//    });
    
    
    // dispatch_time_t使用 ------------------------------
    
//    double delayInSeconds = 5.0;
//    
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        NSLog(@"dispatch_after: %fs", delayInSeconds);
//    });
    
    
    // 串行队列同步提交 ------------------------------
    // 线程1执行完成后再执行线程2，===执行在1和2之间
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
//    // 使用NULL，默认为串行队列
//    dispatch_queue_t queue_serial = dispatch_queue_create("serial.queue", NULL);
//    dispatch_sync(queue_serial, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程1-----%d", i);
//        }
//    });
//
//    NSLog(@"========================");
//
//    dispatch_sync(queue_serial, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程2-----%d", i);
//        }
//    });
    
    
    // 串行队列异步提交 ------------------------------
    // 线程1执行完成后再执行线程2，===随机执行
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue_serial, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程1-----%d", i);
//        }
//    });
//
//    NSLog(@"========================");
//
//    dispatch_async(queue_serial, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程2-----%d", i);
//        }
//    });
    
    
    // 并行队列同步提交 ------------------------------
    // 线程1执行完成后再执行线程2，===执行在1和2之间
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_sync(queue_concurrent, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程1-----%d", i);
//        }
//    });
//
//    NSLog(@"========================");
//
//    dispatch_sync(queue_concurrent, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程2-----%d", i);
//        }
//    });
    
    
    // 并行队列异步提交 ------------------------------
    // 1，2，===随机轮流执行
    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue_concurrent, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程1-----%d", i);
//        }
//    });
//
//    NSLog(@"========================");
//
//    dispatch_async(queue_concurrent, ^{
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程2-----%d", i);
//        }
//    });
    

    // 3. 主队列（串行队列）同步提交导致死锁  ------------------------------
    // 主队列等待block完成才能继续执行，因为ViewDidLoad运行在主队列，而block任务也同步提交在主队列，需要等到ViewDidLoad任务完成才能继续执行
    
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"Deadlock");
//    });
    
    
    // 4. 主队列（串行队列）同步提交导致死锁  ------------------------------
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_sync(queue_serial, ^{
//        
//        NSLog(@"I'm here");
//        
//        dispatch_sync(queue_serial, ^{
//            NSLog(@"Deadlock");
//        });
//        
//        for (int i = 0; i < 100; i++) {
//            NSLog(@"线程-----%d", i);
//        }
//    });


    // GCD下载图片 ------------------------------
    
//    dispatch_queue_t queue_serial = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_SERIAL);
//    dispatch_async(queue_serial, ^{
//        
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/bmiddle/7f6fbecdjw1emjmw7uzrlj218g18edjt.jpg"]];
//        UIImage *image = [UIImage imageWithData:data];
//        
//        if (image) {
//            [self performSelectorOnMainThread:@selector(updateUI:) withObject:image waitUntilDone:YES];
////            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
////                self.imageView.image = image;
////            }];
//        } else {
//            NSLog(@"下载失败");
//        }
//    });
    
    
    // dispatch_group的使用 ------------------------------
    
    // Dispatch Group 会在整个组的任务都完成时通知你。这些任务可以是同步的，也可以是异步的，即便在不同的队列也行。
    // 而且在整个组的任务都完成时，Dispatch Group 可以用同步的或者异步的方式通知你。因为要监控的任务在不同队列，那就用一个dispatch_group_t 的实例来记下这些不同的任务
    // dispatch_group_async可以实现监听一组任务是否完成，完成后得到通知执行其他的操作。比如你执行三个下载任务，当三个任务都下载完成后你才通知界面说完成了
    
//    dispatch_queue_t queue_global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("com.myQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_group_t group = dispatch_group_create();
//    
//    dispatch_group_async(group, queue_global, ^{
//        
//        NSLog(@"Group1 start");
//        
//        [self downloadImageOperation:@"http://ww3.sinaimg.cn/bmiddle/c0788b86jw1enf37mcveyj20c84tj4gq.jpg"];
//        
//         NSLog(@"Group1 download finished");
//    });
//    // 不同队列
//    dispatch_group_async(group, queue_concurrent, ^{
//        
//        NSLog(@"Group2 start");
//        
//        [NSThread sleepForTimeInterval:10];
//        
//        NSLog(@"Group2 finished");
//    });
//    
//    dispatch_group_async(group, queue_global, ^{
//        
//        NSLog(@"Group3 start");
//        
//        [self downloadImageOperation:@"http://ww2.sinaimg.cn/bmiddle/7f6fbecdjw1emjmw7uzrlj218g18edjt.jpg"];
//        
//        NSLog(@"Group3 download finished");
//    });
//    
//    // 三个任务都完成时候再通知
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"updateUI");
//    });
    
    
    // dispatch_barrier使用 ------------------------------
    // 在并发队列上扮演一个串行式的瓶颈，相当于@synchronized(self)
    // 1执行完成后再执行2
    
//    __block int count = 1000;
//    
//    dispatch_queue_t queue_concurrent = dispatch_queue_create("serial.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue_concurrent, ^{
//        dispatch_barrier_async(queue_concurrent, ^{
//            for (int i = 0; i < 500; i++) {
//                count--;
//                NSLog(@"1 count: %d", count);
//            }
//        });
//    });
//    
//    dispatch_async(queue_concurrent, ^{
//        dispatch_barrier_async(queue_concurrent, ^{
//            for (int i = 0; i < 500; i++) {
//                count--;
//                NSLog(@"2 count: %d", count);
//            }
//        });
//    });
}

- (void)downloadImageOperation:(NSString *)urlString
{
    NSLog(@"current thread: %@", [NSThread currentThread]);
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
    UIImage *image = [UIImage imageWithData:data];
    if (image) {
        NSLog(@"下载成功");
    } else {
        NSLog(@"下载失败");
    }
}

- (void)updateUI:(UIImage *)image
{
    self.imageView.image = image;
}

@end
