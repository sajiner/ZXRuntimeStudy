//
//  UIViewController+Extension.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/22.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/runtime.h>

@implementation UIViewController (Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSel = @selector(viewWillAppear:);
        SEL swizzledSel = @selector(x_viewWillAppear:);
        
        Method originalMe = class_getInstanceMethod(class, originalSel);
        Method swizzledMe = class_getInstanceMethod(class, swizzledSel);
        
        BOOL didAddMethod = class_addMethod(class, originalSel, method_getImplementation(originalMe), method_getTypeEncoding(swizzledMe));
        if (didAddMethod) {
            class_replaceMethod(class, swizzledSel, method_getImplementation(swizzledMe), method_getTypeEncoding(originalMe));
        } else {
            method_exchangeImplementations(originalMe, swizzledMe);
        }
    });
}

- (void)x_viewWillAppear:(BOOL)animated {
    [self x_viewWillAppear:animated];
    NSLog(@"viewWillAppear: %@", self);
}

@end
