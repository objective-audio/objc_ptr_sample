//
//  TestClass.h
//  objc_ptr_sample
//
//  Created by Yuki Yasoshima on 2017/09/08.
//  Copyright © 2017年 Yuki Yasoshima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestClass : NSObject

- (instancetype)initWithText:(NSString *)text;

@property (nonatomic, copy, readonly) NSString *text;

@end
