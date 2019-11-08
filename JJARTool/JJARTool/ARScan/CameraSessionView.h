//
//  CameraSessionView.h
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraSessionManager.h"

@protocol JJCameraSessionDelegate <NSObject>

- (void)captureImageCancel;

- (void)captureImageFinished:(UIImage *)image;

@end

//-------------------------- topBar ------------------------------------
@interface CameraTopBar : UIView

@property (nonatomic, strong) UIImage *background;
//闪光灯
@property (nonatomic, strong) UIButton *flashBtn;

@end

//-------------------------- buttomBar ---------------------------------
@interface CameraButtomBar : UIView

//快门
@property (nonatomic, strong) UIButton *shutterBtn;
//返回
@property (nonatomic, strong) UIButton *backBtn;
//切换
@property (nonatomic, strong) UIButton *switchBtn;
//相册
@property (nonatomic, strong) UIButton *albumBtn;

@end



@interface CameraSessionView : UIView<JJCameraSessionManagerDelegate>

@property (nonatomic, weak) id<JJCameraSessionDelegate> delegate;

@property (nonatomic, strong) CameraSessionManager *captureManager;

@property (nonatomic, strong) CameraButtomBar *buttomBar;

@property (nonatomic, assign) CameraType cameraType;

- (void)setTopBarColor:(UIColor *)topBarColor;
- (void)hideButtomBar:(BOOL)isHide;

@end
