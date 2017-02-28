//
//  BinaryTreeNode.h
//  ZXRuntimeStudy
//
//  Created by sajiner on 2017/2/24.
//  Copyright © 2017年 sajiner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BinaryTreeNode : NSObject

@property (nonatomic, assign) NSInteger value;

@property (nonatomic, strong) BinaryTreeNode *leftNode;

@property (nonatomic, strong) BinaryTreeNode *rightNode;



@end
