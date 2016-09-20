//
//  UIViewController+Log.m
//  CAAnimationDemo
//
//  Created by Jade on 16/3/23.
//  Copyright © 2016年 Jade. All rights reserved.
//

/**
 *  runtime IMP 实现用类别执行viewDidLoad方法
 *
 */

#import "UIViewController+Log.h"

#import <objc/runtime.h>

typedef void(*_IMP)(id,SEL,...);

@implementation UIViewController (Log)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
         //获取viewDidLoad的方法是一个Method结构体
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
         //获取新创建的方法
        Method viewHisDidLoad = class_getInstanceMethod(self, @selector(viewHisDidLoad));
        //两个方法互换实现
        method_exchangeImplementations(viewDidLoad, viewHisDidLoad);
        
    });
}

- (void)viewHisDidLoad
{
    [self viewHisDidLoad];
    NSLog(@"className:%@",[self class]);
    
    
}
 


/*
+ (void)load
{
    static dispatch_once_t onceToken;//保证只执行一次
    dispatch_once(&onceToken, ^{
        //获取viewDidLoad的方法是一个Method结构体
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        //获取方法的实现
        _IMP viewDidLoad_IMP = (_IMP)method_getImplementation(viewDidLoad);
        //重置方法的实现
        method_setImplementation(viewDidLoad, imp_implementationWithBlock(^(id target,SEL action) {
            viewDidLoad_IMP(target,@selector(viewDidLoad));
            //打印本类的名字
            NSLog(@"className:%@",[target class]);
        }));
    });
}
*/
@end
