//
//  JJARScanService.h
//  JJARTool
//
//  Created by shenjie on 2019/11/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJARScanService : NSObject

+ (JJARScanService *)shareInstance;

- (void)openARCamera:(UIViewController *)baseView option:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
