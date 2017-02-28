//
//  main.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/13.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <objc/Object.h>
#import "MyClass.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        
//        MyClass *myClass = [[MyClass alloc] init];
//        Class class = myClass.class;
//        
//        // 类名
//        NSLog(@"class name: %s", class_getName(class));
//        NSLog(@"=======================");
//        
//        // 父类
//        NSLog(@"super class name: %s", class_getName(class_getSuperclass(class)));
//        NSLog(@"=======================");
//        
//        // 是否是元类
//        NSLog(@"MyClass is %d a meta-class", class_isMetaClass(class));
//        NSLog(@"=======================");
//        
//        Class meta_class = objc_getMetaClass(class_getName(class));
//        NSLog(@"%s's meta-class is %s", class_getName(class), class_getName(meta_class));
//        NSLog(@"=======================");
//        
//        // 变量实例大小
//        NSLog(@"instance size: %zu", class_getInstanceSize(class));
//        NSLog(@"=======================");
//        
//        // 成员变量
//        unsigned int outCount = 0;
//        Ivar *ivars = class_copyIvarList(class, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            Ivar ivar = ivars[i];
//            NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
//        }
//        free(ivars);
//        NSLog(@"=======================");
//        Ivar str = class_getInstanceVariable(class, "_name");
//        if (str != NULL) {
//            NSLog(@"instance variable %s", ivar_getName(str));
//        }
//        NSLog(@"=======================");
//        
//        // 属性操作
//        objc_property_t *properties = class_copyPropertyList(class, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            objc_property_t property = properties[i];
//            NSLog(@"property's name: %s", property_getName(property));
//        }
//        free(properties);
//        NSLog(@"=======================");
//        
//        // 方法操作
//        Method *methods = class_copyMethodList(class, &outCount);
//        for (int i = 0; i < outCount; i++) {
//            Method method = methods[i];
//            NSLog(@"method's signature: %s", method_getName(method));
//        }
//        free(methods);
//        
//        Method method1 = class_getInstanceMethod(class, @selector(method1));
//        if (method1 != NULL) {
//            NSLog(@"class method: %s", method_getName(method1));
//        }
//        
//        IMP imp = class_getMethodImplementation(class, @selector(method1));
//        imp();
//        NSLog(@"=======================");
//        
//        // 协议
//        Protocol *__unsafe_unretained *protocols = class_copyProtocolList(class, &outCount);
//        Protocol *protocol;
//        for (int i = 0; i < outCount; i++) {
//            protocol = protocols[i];
//            NSLog(@"protocol name: %s", protocol_getName(protocol));
//        }
//        NSLog(@"MyClass is %@ responsed to protocol %s", class_conformsToProtocol(class, protocol) ? @"" : @"not" , protocol_getName(protocol));
//        NSLog(@"=======================");
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
