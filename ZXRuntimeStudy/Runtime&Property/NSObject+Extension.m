
//
//  NSObject+Extension.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/21.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "NSObject+Extension.h"
#import <objc/runtime.h>

/// 三种方式是一样的
//static NSString *strKey = @"strKey";
//static void *strKey = &strKey;
static char strKey;


@implementation NSObject (Extension)

/**
 Json到Model的转化:
    用runtime提供的函数遍历Model自身所有属性，如果属性在json中有对应的值，则将其赋值
 */
- (instancetype)initWithDict: (NSDictionary *)dict {
    if (self = [self init]) {
        
        NSMutableArray *keys = [NSMutableArray array];
        NSMutableArray *attributes = [NSMutableArray array];
        
        unsigned int outCount;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            // 获得属性的名字
            NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            [keys addObject:propertyName];
             //通过property_getAttributes函数可以获得属性的名字和@encode编码
            NSString *propertyAttribute = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
            [attributes addObject:propertyAttribute];
        }
        free(properties);
        
        for (NSString *key in keys) {
            if ([dict valueForKey:key] == nil) {
                continue;
            }
        }
    }
    return self;
}

/* 为分类添加属性 */
- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, &strKey, name,OBJC_ASSOCIATION_COPY);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, &strKey);
}

@end
