//
//  MyClass.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/13.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "MyClass.h"

@interface MyClass () {
    NSInteger _instance1;
    NSString *_instance2;
}

@property (nonatomic, assign) NSUInteger integer;


- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2;

@end

@implementation MyClass

- (void)method1 {
    NSLog(@"call method method1");
}

- (void)method2 {
    
}

+ (void)classMethod1 {
    
}

- (void)method3WithArg1:(NSInteger)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1 : %ld, arg2 : %@", arg1, arg2);
}

@end
