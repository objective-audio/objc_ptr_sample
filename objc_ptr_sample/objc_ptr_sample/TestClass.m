//
//  TestClass.m
//  objc_ptr_sample
//
//  Created by Yuki Yasoshima on 2017/09/08.
//  Copyright © 2017年 Yuki Yasoshima. All rights reserved.
//

#import "TestClass.h"

@implementation TestClass {
    NSString *_text;
}

- (instancetype)init
{
    return [self initWithText:@""];
}

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _text = [text copy];

        NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);

    [_text release];
    [super dealloc];
}

@end
