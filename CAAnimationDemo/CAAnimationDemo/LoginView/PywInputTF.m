//
//  PywInputTF.m
//  PywSdk
//
//  Created by liangyidong on 16/3/2.
//  Copyright © 2016年 zero. All rights reserved.
//

#import "PywInputTF.h"

@implementation PywInputTF

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.keyboardType = UIKeyboardTypeASCIICapable;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    return self;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    return CGRectMake(bounds.origin.x + 5, 5 , 20, 20);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super rightViewRectForBounds:bounds];
    return CGRectMake(rect.origin.x - 5, 5, 20, 20);
}

@end
