//
//  ObjCClass.h
//  objc_ptr_sample
//
//  Created by Yuki Yasoshima on 2017/09/09.
//  Copyright © 2017年 Yuki Yasoshima. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc_ptr.hpp"
#import "TestClass.h"

@interface ObjCClass : NSObject

- (void)setTestObject:(TestClass *)object;
- (TestClass *)testObject;

@end
