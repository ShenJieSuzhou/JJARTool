//
//  CameraSessionView.m
//  JJImagePickerDemo
//
//  Created by shenjie on 2018/7/12.
//  Copyright © 2018年 shenjie. All rights reserved.
//



#import "CameraSessionView.h"

const UIEdgeInsets backBtnMargins = {10, 10, 0, 0};
const UIEdgeInsets switchBtnMargins = {10, 0, 0, 10};
const UIEdgeInsets flashBtnMargins = {10, 0, 0, 0};

@implementation CameraTopBar
@synthesize background = _background;
@synthesize flashBtn = _flashBtn;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    [self setBackground:_background];
    
    self.flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.flashBtn setBackgroundColor:[UIColor clearColor]];
    [self.flashBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self addSubview:self.flashBtn];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
//    [self.flashBtn setFrame:CGRectMake(self.frame.size.width - self.switchBtn.frame.size.width - 30 - switchBtnMargins.right * 2, flashBtnMargins.top, 30, 30)];
}

@end

@implementation CameraButtomBar

@synthesize backBtn = _backBtn;
@synthesize shutterBtn = _shutterBtn;
@synthesize switchBtn = _switchBtn;
@synthesize albumBtn = _albumBtn;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    //无背景色
    [self setBackgroundColor:[UIColor clearColor]];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundColor:[UIColor clearColor]];
    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"closeButton"] forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    
    self.shutterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.shutterBtn setBackgroundColor:[UIColor clearColor]];
    [self.shutterBtn setImage:[UIImage imageNamed:@"cameraButton"] forState:UIControlStateNormal];
    [self.shutterBtn setImage:[UIImage imageNamed:@"cameraButton"] forState:UIControlStateSelected];
    
    self.switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.switchBtn setBackgroundColor:[UIColor clearColor]];
    [self.switchBtn setBackgroundImage:[UIImage imageNamed:@"swapButton"] forState:UIControlStateNormal];
    [self addSubview:self.switchBtn];
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        [self.shutterBtn setFrame:CGRectMake(0, 0, 100, 100)];
    }else{
        [self.shutterBtn setFrame:CGRectMake(0, 0, 80, 80)];
    }
    
    [self addSubview:self.backBtn];
    [self addSubview:self.shutterBtn];
    [self addSubview:self.switchBtn];
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self.backBtn setFrame:CGRectMake(25, 25, 50, 50)];
    
    [self.shutterBtn setFrame:CGRectMake((self.frame.size.width - self.shutterBtn.frame.size.width)/2, 10, self.shutterBtn.frame.size.width, self.shutterBtn.frame.size.height)];
    
    [self.switchBtn setFrame:CGRectMake(self.frame.size.width - 50 - 25, 25, 50, 50)];
}

@end


@implementation CameraSessionView
@synthesize captureManager = _captureManager;
@synthesize buttomBar = _buttomBar;
@synthesize cameraType = _cameraType;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self commonInitlization];
    }
    
    return self;
}

- (id)init{
    return [self initWithFrame:CGRectZero];
}

- (void)commonInitlization{
    _cameraType = RearFacingCamera;
    [self setupCaptureManager:_cameraType];
    [self composeInterface];
    [_captureManager.session startRunning];
}

-(void)setupCaptureManager:(CameraType)camera {
    // remove existing input
    AVCaptureInput* currentCameraInput = [self.captureManager.session.inputs objectAtIndex:0];
    [self.captureManager.session removeInput:currentCameraInput];
    _captureManager = nil;
    
    //setup
    _captureManager = [CameraSessionManager getInstance];
    [_captureManager.session beginConfiguration];
    
    if(_captureManager){
        //config
        [_captureManager setDelegate:self];
        [_captureManager initiateCaptureSessionForCamera:camera];
        [_captureManager addStillImageOutput];
        [_captureManager addVideoPreviewLayer];
        [self.captureManager.session commitConfiguration];
        
        //preview layer setup
        CGRect layerRect = self.layer.bounds;
        [_captureManager.previewLayer setBounds:layerRect];
        [_captureManager.previewLayer setPosition:CGPointMake(CGRectGetMidX(layerRect),CGRectGetMidY(layerRect))];
        
        //apply animation effect to the camera's preview layer
        CATransition *applicationLoadViewIn = [CATransition animation];
        [applicationLoadViewIn setDuration:0.6];
        [applicationLoadViewIn setType:kCATransitionReveal];
        [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [_captureManager.previewLayer addAnimation:applicationLoadViewIn forKey:kCATransitionReveal];
        
        [self.layer addSublayer:_captureManager.previewLayer];
    }
}

-(void)composeInterface {
    
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ){
        
    }else{
        self.buttomBar = [[CameraButtomBar alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 100, self.frame.size.width, 100)];
        [self.buttomBar.shutterBtn addTarget:self action:@selector(clickShutterBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttomBar.backBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttomBar.switchBtn addTarget:self action:@selector(ClickSwitchBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.buttomBar];
    }
}

#pragma mark -buttom click event
//按下快门
- (void)clickShutterBtn:(UIButton *)sender{
    [_captureManager captureStillImage];
}

- (void)dismiss:(UIButton *)sender{
    [_captureManager stop];
    [_delegate captureImageCancel];
}

- (void)ClickSwitchBtn:(UIButton *)sender{
    if(_cameraType == FrontFacingCamera){
        _cameraType = RearFacingCamera;
        [self setupCaptureManager:_cameraType];
        [self composeInterface];
        [_captureManager.session startRunning];
    }else{
        _cameraType = FrontFacingCamera;
        [self setupCaptureManager:_cameraType];
        [self composeInterface];
        [_captureManager.session startRunning];
    }
}

- (void)setTopBarColor:(UIColor *)topBarColor{
    
}

- (void)hideButtomBar:(BOOL)isHide{
    [self.buttomBar setHidden:isHide];
}

#pragma mark -JJCameraSessionManagerDelegate
- (void)captureOutputDidFinish:(UIImage *)image{
    if([_delegate respondsToSelector:@selector(captureImageFinished:)]){
        [_delegate captureImageFinished:image];
    }
}

- (void)captureOutputWithError:(NSError *)error{
    
}

@end
