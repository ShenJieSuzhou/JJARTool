//
//  JJARCameraView.m
//  JJARTool
//
//  Created by shenjie on 2019/11/8.
//  Copyright © 2019 shenjie. All rights reserved.
//

#import "JJARCameraView.h"

@interface JJARCameraView ()

@end

@implementation JJARCameraView
@synthesize captureDevice = _captureDevice;
@synthesize session = _session;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)initiateCaptureSessionForCamera:(CameraType)cameraType{
    //初始化摄像头
    for (AVCaptureDevice *device in AVCaptureDevice.devices) {
        if([device hasMediaType:AVMediaTypeVideo]){
            switch (cameraType) {
                case FrontFacingCamera:
                    if([device position] == AVCaptureDevicePositionFront){
                        _captureDevice = device;
                    }
                    break;
                case RearFacingCamera:
                    if([device position] == AVCaptureDevicePositionBack){
                        _captureDevice = device;
                    }
                    break;
            }
        }
    }
    
    self.session = [[AVCaptureSession alloc] init];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    NSError *error = nil;
    BOOL deviceAvailability = YES;
    
    AVCaptureDeviceInput *cameraDeviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_captureDevice error:&error];
    
    if(!error && [_session canAddInput:cameraDeviceInput]){
        [_session addInput:cameraDeviceInput];
    }else{
        deviceAvailability = NO;
    }
}

- (void)stopCapture{
    [self.session stopRunning];

    if(self.session.inputs.count > 0){
        AVCaptureInput *input = [self.session.inputs objectAtIndex:0];
        [self.session removeInput:input];
    }

    if(self.session.outputs.count > 0){
        AVCaptureVideoDataOutput *output = [self.session.outputs objectAtIndex:0];
        [self.session removeOutput:output];
    }
}

- (void)dealloc{
    [self stopCapture];
}

#pragma mark -AVCapturePhotoCaptureDelegate
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error{
    
//    NSData *imageData = photo.fileDataRepresentation;
//    UIImage *image = [UIImage imageWithData:imageData];
//
//    if(error){
//        [_delegate captureOutputWithError:error];
//        return;
//    }
//
//    [_delegate captureOutputDidFinish:image];
}

@end
