//
//  ViewController.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/13.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import <pthread.h>

@interface ViewController ()

@property (nonatomic, strong) NSInvocationOperation *invocationOp;

@end


@implementation ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
   
    dispatch_queue_t serialQueue = dispatch_queue_create("serialQueue", NULL);
    
    dispatch_sync(serialQueue, ^{
        NSLog(@"开启了一个异步任务task，当前线程：%@", [NSThread currentThread]);
        
    });
}

// 多线程的目的：通过并行？执行提高CPU使用率，进而提供程序运行效率

// 同步和异步决定了是否开启新的线程。main队列除外，在main队列中，同步或者异步执行都会阻塞当线的main线程，且不会另开线程。当然，永远不要使用sync向主队列中添加任务，这样子会线程卡死


/*
 不要使用sync（同步）向串行队列添加任务，否则会产生死锁。
 dispatch_sync(dispatch_get_main_queue(), ^{
     NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
 });
 */

/*
 线程同步：
    为防止多个线程抢夺同一个资源造成的数据安全问题，采取的一种措施
互斥锁：给需要同步的代码块，加一个互斥锁
同步执行：把多个线程都要执行的此段代码添加到同一个串行队列
 
 */


/*
 NSOperation:
 是对GCD的封装，面向对象
 操作步骤：
     1.将要执行的任务封装到一个NSOperation对象中
     2.将此任务添加到一个NSOperationQueue对象中
 * 可以给任务添加依赖
 
 */

- (void)oprationDemo3 {
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
   
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *blockOp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
    NSBlockOperation *blockOp2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
    NSBlockOperation *blockOp3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
    NSBlockOperation *blockOp4 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
        
    [queue addOperations:@[blockOp, blockOp1, blockOp2, blockOp3, blockOp4] waitUntilFinished:NO];
    NSLog(@"%ld", queue.operationCount);
}


- (void)oprationDemo2 {
    NSBlockOperation *blockOp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"NSBlockOperation : %@", [NSThread currentThread]);
    }];
    for (int i = 0; i < 3; i++) {
        // addExecutionBlock 必须在start方法之前执行
        [blockOp addExecutionBlock:^{
            NSLog(@"第%d次 : %@",i, [NSThread currentThread]);
        }];
    }
    [blockOp start];
}

- (void)oprationDemo1 {
    _invocationOp = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(run) object:nil];
    [_invocationOp start];
}

- (void)run {
    for (int i = 0; i < 5; i++) {
        if (i == 2) {
            [_invocationOp cancel];
        }
        NSLog(@"NSInvocationOperation : %@", [NSThread currentThread]);
    }
}

/*
 GCD:
 任务：执行方式：同步和异步
 同步：会阻塞当前线程
 异步：不会阻塞当前线程
 队列：存放任务；分类：串行和并行
 串行：（同步：当前线程，一个一个执行），（异步：其他线程，一个一个执行）
 并行：（同步：当前线程，一个一个执行），（异步：开多个线程，一起执行）
 */

- (void)gcdDemo3 {
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 3; i++) {
            NSLog(@"group-01 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 8; i++) {
            NSLog(@"group-02 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"group-03 - %@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
    });
    
}

- (void)gcdDemo2{
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"之前%@", [NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"sync之前%@", [NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"%@", [NSThread currentThread]);
        });
        NSLog(@"sync之后%@", [NSThread currentThread]);
    });
    NSLog(@"之后%@", [NSThread currentThread]);
}

- (void)gcdDemo1 {
    NSLog(@"之前%@", [NSThread currentThread]);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    NSLog(@"之后%@", [NSThread currentThread]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    id theObject = class_createInstance(NSString.class, sizeof(unsigned));
    id str1 = [theObject init];
    NSLog(@"%@", [str1 class]);
    
    id str2 = [[NSString alloc] init];
    NSLog(@"%@", [str2 class]);
    
    /// SEL：方法选择器
    /// Objective-C在编译时，会依据每一个方法的名字、参数序列，生成一个唯一的整型标识(Int类型的地址)，这个标识就是SEL
    /// 两个类之间，不管它们是父类与子类的关系，还是之间没有这种关系，只要方法名相同，那么方法的SEL就是一样的
    /// 不同的类可以拥有相同的selector，这个没有问题。不同类的实例对象执行相同的selector时，会在各自的方法列表中去根据selector去寻找自己对应的IMP
    /// 有一个问题，就是数量增多会增大hash冲突而导致的性能下降（或是没有冲突，因为也可能用的是perfect hash）
    /// 但是不管使用什么样的方法加速，如果能够将总量减少（多个方法可能对应同一个SEL），那将是最犀利的方法
 
    SEL me = @selector(method);
    NSLog(@"%p", me);
    
  
}

void functionForMethod(id self, SEL _cmd) {
    
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectoeStr = NSStringFromSelector(sel);
    if ([selectoeStr isEqualToString:@"method"]) {
        class_addMethod([self class], @selector(method), (IMP)functionForMethod, "@:");
    }
    return [super resolveInstanceMethod:sel];
}

- (void)setWidth:(int)width {
   
}
- (void)method {
    NSLog(@"come here");
}

/*
 运行时获取SEL的三种方式：
 @selector(<#selector#>)
 NSSelectorFromString(<#NSString * _Nonnull aSelectorName#>)
 sel_registerName(<#const char *str#>)
 */

/// IMP: 就是一个函数指针，指向方法实现的首地址
/*
 id (*IMP)(id, SEL, ...):
 第一个参数是指向self的指针(如果是实例方法，则是类实例的内存地址；如果是类方法，则是指向元类的指针);
 第二个参数是方法选择器(selector)，
 接下来是方法的实际参数列表
 */

/*
 消息分发：
 objc_msgSend（）
 跳过消息分发，直接调用函数：
 methodForSelector
 */

/// Method用于表示类定义中的方法

/// 如果想要避开这种动态绑定方式，我们可以获取方法实现的地址，然后像调用函数一样来直接调用它。特别是当我们需要在一个循环内频繁地调用一个特定的方法时，通过这种方式可以提高程序的性能。

/*
 消息转发三个步骤：
 1.动态方法解析
 2.备用接收者
 3.完整转发
 */


/*
 Method Swizzling 是改变selector的实际实现的技术
 通过此技术，可以在运行时通过修改类的分发表中selelctor对应的函数，来修改方法的实现
 
 
 */

@end


