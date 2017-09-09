//
//  ObjCClass.m
//  objc_ptr_sample
//
//  Created by Yuki Yasoshima on 2017/09/09.
//  Copyright © 2017年 Yuki Yasoshima. All rights reserved.
//

#import "ObjCClass.h"

@implementation ObjCClass {
    objc_ptr<TestClass *> _test_ptr;
}

- (void)setTestObject:(TestClass *)object {
    _test_ptr = object;
//    _test_ptr = objc_ptr<TestClass *>(object); // と同じ
}

- (TestClass *)testObject {
    return *_test_ptr;
}

@end
