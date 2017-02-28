//
//  BinaryTreeNode.m
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/24.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode


/**
 创建二叉排序树

 @param values 数组
 @return 二叉树根节点
 */
+ (BinaryTreeNode *)createTreeWithValues: (NSArray *)values {
    BinaryTreeNode *root = nil;
    for (int i = 0; i < values.count; i++) {
        NSInteger value = [(NSNumber *)values[i] integerValue];
        root = [BinaryTreeNode addTreeNode:root value:value];
    }
    return root;
}


/**
 返回二叉树根节点

 @param treeNode 根节点
 @param value 值
 @return 根节点
 */
+ (BinaryTreeNode *)addTreeNode: (BinaryTreeNode *)treeNode value: (NSInteger)value {
    if (!treeNode) {
        treeNode = [BinaryTreeNode new];
        treeNode.value = value;
        NSLog(@"node: %ld", value);
    } else if (value < treeNode.value) {
        treeNode.leftNode = [BinaryTreeNode addTreeNode:treeNode.leftNode value:value];
    } else {
        treeNode.rightNode = [BinaryTreeNode addTreeNode:treeNode.rightNode value:value];
    }
    return treeNode;
}

@end
