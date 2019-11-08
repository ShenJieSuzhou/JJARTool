//
//  ViewController.m
//  JJARTool
//
//  Created by shenjie on 2019/11/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "ViewController.h"
#import <AipOcrSdk/AipOcrSdk.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (IBAction)startRecognize:(id)sender {
    NSLog(@"开始识别");
    
    NSDictionary *options = @{@"language_type": @"CHN_ENG", @"detect_direction": @"true"};
    UIImage *img = [UIImage imageNamed:@"test"];
    [[AipOcrService shardService] detectTextFromImage:img withOptions:options successHandler:^(id result) {
        // 成功识别的后续逻辑
        NSLog(@"%@", result);
        
    } failHandler:^(NSError *err) {
        // 失败的后续逻辑
        NSLog(@"%@", err);
    }];
}

@end
