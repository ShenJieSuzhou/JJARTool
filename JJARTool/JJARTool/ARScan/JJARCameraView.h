//
//  JJARCameraView.h
//  JJARTool
//
//  Created by shenjie on 2019/11/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(BOOL, CameraType){
    FrontFacingCamera,
    RearFacingCamera
};

@interface JJARCameraView : UIViewController<AVCapturePhotoCaptureDelegate>

//相机设备
@property (nonatomic, strong) AVCaptureDevice *captureDevice;

//用于捕捉视频和音频,协调视频和音频的输入和输出流
@property (nonatomic, strong) AVCaptureSession *session;


- (void)initiateCaptureSessionForCamera:(CameraType)cameraType;

- (void)stopCapture;

@end

NS_ASSUME_NONNULL_END
