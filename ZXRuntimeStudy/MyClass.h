//
//  MyClass.h
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/13.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject

@property (nonatomic, strong) NSArray *lists;

@property (nonatomic, copy) NSString *name;

- (void)method1;
- (void)method2;
+ (void)classMethod1;

@end
