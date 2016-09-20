//
//  Network.m
//  CAAnimationDemo
//
//  Created by Jade on 4/11/16.
//  Copyright © 2016 Jade. All rights reserved.
//

#import "Network.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@implementation Network
+ (id)shareIntance
{
    static id onceObj = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        onceObj = [[[self class] alloc] init];
    });
    return onceObj;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**
 *  网络类型
 *
 *  @return <#return value description#>
 */
- (NSString *)networkType
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    NSLog(@"carrierName:%@:%@",carrier.carrierName,[self networkInfo]);
    return networkInfo.currentRadioAccessTechnology;
}


- (NSString *)networkInfo
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentRadioAccessTechnology = [info currentRadioAccessTechnology];
    NSString *networkStatus = @"NotReachable";
    if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
        networkStatus = @"4G";
    }else if ([currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge] || [currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS]) {
        networkStatus = @"2G";
    }else {
        networkStatus = @"3G";
    }
    return networkStatus;
}



@end
