//
//  NSObject+Extension.h
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/21.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extension)

/*
 不能为一个类动态的添加成员变量，可以给类动态增加方法和属性。
    因为方法和属性并不“属于”类实例，而成员变量“属于”类实例。我们所说的“类实例”概念，指的是一块内存区域，包含了isa指针和所有的成员变量。所以假如允许动态修改类成员变量布局，已经创建出的类实例就不符合类定义了，变成了无效对象。但方法定义是在objc_class中管理的，不管如何增删类方法，都不影响类实例的内存布局，已经创建出的类实例仍然可正常使用
 */

/// 为分类添加属性
@property (nonatomic, copy) NSString *name;


@end
