//
//  ViewController.m
//  NSThread_GCD
//
//  Created by Seven on 2020/11/1.
//  Copyright © 2020 binart. All rights reserved.
//

#import "ViewController.h"
#import "UserRepo.h"

@interface ViewController ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;
@property (nonatomic, strong) dispatch_queue_t queue;

@property (nonatomic, weak) IBOutlet UILabel *NSThreadLabel;
@property (nonatomic, weak) IBOutlet UILabel *GCDLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.queue = dispatch_queue_create("download", DISPATCH_QUEUE_CONCURRENT);
}

- (NSString *)printMS {

    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;

    [formatter setDateStyle:NSDateFormatterMediumStyle];

    [formatter setTimeStyle:NSDateFormatterShortStyle];

    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制

    //设置时区,这个对于时间的处理有时很重要

    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];

    [formatter setTimeZone:timeZone];

    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式

//    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];

    return [formatter stringFromDate:datenow];
    
    // WCDB ERROR: concurrency of database exceeds the max concurrency

}

- (void)doWork {
    
    for (NSInteger i = 0; i < 1000; i++) {
        [[UserRepo shared] addOne:@"李杰" age:90];
    }

    dispatch_semaphore_signal(self.semaphore);
}

- (IBAction)onTestNSThread:(id)sender {
    NSTimeInterval start = [[NSDate new] timeIntervalSince1970];
    
    self.semaphore = dispatch_semaphore_create(1);
    
    for (NSInteger i = 0; i < 100; i++) {
        [NSThread detachNewThreadSelector:@selector(doWork) toTarget:self withObject:nil];
    }
    
    for (NSInteger j = 0; j < 100; j ++) {
        dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    }
    
//    2020-11-03 00:55:46.845367+0800 NSThread_GCD[35204:1467983] ======> NSThread start at: 2020-11-03 00:55:46 845
//    2020-11-03 00:56:25.787796+0800 NSThread_GCD[35204:1467983] ======> NSThread end at: 2020-11-03 00:56:25 788
    
    // 执行完之后，100线程没有关闭，需要手动关闭！！！
    
    NSLog(@"======> NSThread end at: %@ s", @([[NSDate new] timeIntervalSince1970] - start));
    
    self.NSThreadLabel.text = [NSString stringWithFormat:@"耗时 %@ s", @((long)([[NSDate new] timeIntervalSince1970] - start))];
}

- (IBAction)onTestGCD:(id)sender {
    NSTimeInterval start = [[NSDate new] timeIntervalSince1970];
    
//    dispatch_barrier_async(self.queue, ^{
//        NSLog(@"======> GCD start at: %@", [self printMS]);
//    });
    
    for (NSInteger i = 0; i < 100; i++) {
        dispatch_async(self.queue, ^{
            for (NSInteger i = 0; i < 1000; i++) {
                [[UserRepo shared] addOne:@"李杰" age:90];
            }
//            NSLog(@"======> GCD at: %@", @(i)); // 1. 队列中操作超过64，如果有耗时操作，则后续操作被block 2. 当最大操作大于64，cpu基本灰白拉满，在mac上 CPU 接近 1000%
            
//            2020-11-03 00:54:36.087533+0800 NSThread_GCD[35186:1466651] ======> GCD start at: 2020-11-03 00:54:36 087
//            2020-11-03 00:55:03.796470+0800 NSThread_GCD[35186:1466724] ======> GCD end at: 2020-11-03 00:55:03 796
            
            // 执行完之后，64线程没有关闭 ，什么时候回收呢？
        });
    }
    
    dispatch_barrier_sync(self.queue, ^{ // 所谓栅栏函数，就是前面不管多少异步操作，栅栏把它么都挡住，都执行完，则执行栅栏操作。
        NSLog(@"======> GCD end at: %@ s", @([[NSDate new] timeIntervalSince1970] - start));
        
        self.GCDLabel.text = [NSString stringWithFormat:@"耗时 %@ s", @((long)([[NSDate new] timeIntervalSince1970] - start))];
    });
}

@end