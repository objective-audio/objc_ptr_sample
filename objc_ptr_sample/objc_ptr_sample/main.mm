//
//  main.m
//  objc_ptr_sample
//
//  Created by Yuki Yasoshima on 2017/09/08.
//  Copyright © 2017年 Yuki Yasoshima. All rights reserved.
//

#import "ObjCClass.h"

void sample_construct_with_objc_object() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    @autoreleasepool {
        TestClass *testObj = [[[TestClass alloc] initWithText:@"construct_with_objc_object"] autorelease];

        objc_ptr<TestClass *> test_ptr(testObj);

        NSLog(@"text : %@", test_ptr.value().text);
    }

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_make_objc_ptr() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    TestClass *testObj = [[TestClass alloc] initWithText:@"make_objc_ptr"];

    auto test_ptr = make_objc_ptr(testObj);

    NSLog(@"text : %@", test_ptr.value().text);

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_remove_autorelease() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    objc_ptr<TestClass *> test_ptr(
        []() { return [[[TestClass alloc] initWithText:@"remove_autorelease"] autorelease]; });

    NSLog(@"text : %@", test_ptr.value().text);

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_asterisk() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"asterisk"]);

    NSLog(@"text : %@", [*test_ptr text]);

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_operator_bool() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"operator_bool"]);

    if (test_ptr) {
        NSLog(@"test_ptr text : %@", test_ptr.value().text);
    }

    objc_ptr<TestClass *> empty_ptr;

    if (!empty_ptr) {
        NSLog(@"empty_ptr text : %@", empty_ptr.value().text);
    }

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_weak_objc_ptr_from_objc_ptr() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    weak_objc_ptr<TestClass *> weak_ptr;
    {
        auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"weak_objc_ptr_from_objc_ptr"]);

        weak_ptr = test_ptr;

        auto locked_ptr = weak_ptr.lock();

        NSLog(@"retained text : %@", locked_ptr.value().text);
    }

    auto locked_ptr = weak_ptr.lock();

    NSLog(@"released text : %@", locked_ptr.value().text);

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_to_weak() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"to_weak"]);

    auto weak_ptr = to_weak(test_ptr);

    auto locked_ptr = weak_ptr.lock();

    NSLog(@"locked text : %@", locked_ptr.value().text);

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_to_weak_with_lambda() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"to_weak_with_lambda"]);

    auto weak_ptr = to_weak(test_ptr);

    auto handler = [weak_ptr]() {
        auto locked_ptr = weak_ptr.lock();

        NSLog(@"locked text : %@", locked_ptr.value().text);
    };

    handler();

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_to_weak_with_lambda_capture() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    auto test_ptr = make_objc_ptr([[TestClass alloc] initWithText:@"to_weak_with_lambda_capture"]);

    auto handler = [weak_ptr = to_weak(test_ptr)]() {  // C++14
        auto locked_ptr = weak_ptr.lock();

        NSLog(@"locked text : %@", locked_ptr.value().text);
    };

    handler();

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

void sample_instance_var() {
    NSLog(@"begin : %s", __PRETTY_FUNCTION__);

    ObjCClass *objcObj = [[ObjCClass alloc] init];

    TestClass *testObj = [[TestClass alloc] initWithText:@"private_var"];

    [objcObj setTestObject:testObj];

    NSLog(@"text : %@", [objcObj testObject].text);

    [testObj release];

    [objcObj release];

    NSLog(@"end : %s", __PRETTY_FUNCTION__);
}

int main(int argc, const char *argv[]) {
    @autoreleasepool {
        auto const functions = {sample_construct_with_objc_object,
                                sample_make_objc_ptr,
                                sample_remove_autorelease,
                                sample_asterisk,
                                sample_operator_bool,
                                sample_weak_objc_ptr_from_objc_ptr,
                                sample_to_weak,
                                sample_to_weak_with_lambda,
                                sample_instance_var};

        for (auto const &func : functions) {
            func();

            NSLog(@"");
        }
    }
    return 0;
}
