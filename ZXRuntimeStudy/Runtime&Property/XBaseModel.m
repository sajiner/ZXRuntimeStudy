//
//  XBaseModel.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/21.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "XBaseModel.h"
#import <objc/runtime.h>

@implementation XBaseModel

/*
  问题：有时候我们要对一些信息进行归档，如用户信息类UserInfo，这将需要重写initWithCoder和encodeWithCoder方法，并对每个属性进行encode和decode操作，当属性量很大的时候怎么办
  解决方法：用runtime提供的函数遍历Model自身所有属性，并对属性进行encode和decode操作
 
 */

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [self init]) {
        unsigned int outCount;
        Ivar *ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i++) {
            Ivar ivar = ivars[i];
            NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    unsigned int outCount;
    Ivar *ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

@end
