//
//  JJARScanService.m
//  JJARTool
//
//  Created by shenjie on 2019/11/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJARScanService.h"



@implementation JJARScanService

static JJARScanService *_instance = nil;

+ (JJARScanService *)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [self new];
    });
    
    return _instance;
}

- (void)openARCamera:(UIViewController *)baseView option:(NSDictionary *)options{
    
}


@end
