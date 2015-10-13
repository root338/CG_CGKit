//
//  CGQRCodeViewController.m
//  QuickAskCommunity
//
//  Created by DY on 15/9/29.
//  Copyright © 2015年 ym. All rights reserved.
//

#import "CGQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CGPrintLogHeader.h"

#import "NSString+QRCodeURL.h"
#import "QRCodeURLModel.h"

@interface CGQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
{
    BOOL _isMark;
}
@property (strong, nonatomic) AVCaptureSession *captureSession;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation CGQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createReading];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.captureSession.isRunning) {
        [self.captureSession startRunning];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.captureSession.isRunning) {
        [self.captureSession stopRunning];
    }
}

#pragma mark - 相机设置
- (void)createReading
{
    NSError *error = nil;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    
    NSAssert1(!error, @"error :%@", [error localizedDescription]);
    
    self.captureSession = [[AVCaptureSession alloc] init];
    [self.captureSession addInput:input];
    
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    dispatch_queue_t dispatchQueue = dispatch_queue_create("com.cgkit.vc.qrcode", NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    
    [self.captureSession addOutput:captureMetadataOutput];
    
    if ([captureMetadataOutput.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
        
        [captureMetadataOutput setMetadataObjectTypes:@[
                                                        AVMetadataObjectTypeQRCode,
                                                        ]];
    }else {
        
        CGDebugAssert(nil, @"设备不支持二维码扫描");
    };
    
    self.videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.captureSession];
    [self.videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [self.videoPreviewLayer setFrame:self.view.bounds];
    
    CGRect frame = [self setupRectOfInterest];
    captureMetadataOutput.rectOfInterest = frame;
    
    [self.view.layer addSublayer:self.videoPreviewLayer];
    
    [self.captureSession startRunning];
}

- (void)stopReading
{
    [self.captureSession stopRunning];
    self.captureSession = nil;
    [self.videoPreviewLayer removeFromSuperlayer];
}

- (CGRect)setupRectOfInterest
{
    CGSize size = self.view.bounds.size;
    
    CGFloat originX = self.QRCodeVideoFrame.origin.x / size.width;
    CGFloat originY = self.QRCodeVideoFrame.origin.y / size.height;
    CGFloat width   = self.QRCodeVideoFrame.size.width / size.width;
    CGFloat height  = self.QRCodeVideoFrame.size.height / size.height;
    return CGRectMake(originY, originX, height, width);
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *content = nil;
    if (metadataObjects != nil && [metadataObjects count]) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects firstObject];
        
        NSString *codeType = [metadataObj type];
        content = metadataObj.stringValue;
        
        if ([codeType isEqualToString:AVMetadataObjectTypeQRCode]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.captureSession stopRunning];
                
//                AVMetadataMachineReadableCodeObject *transformed = (AVMetadataMachineReadableCodeObject *)[self.videoPreviewLayer transformedMetadataObjectForMetadataObject:metadataObj];
                
                [self callbackMethod:content];
            });
        }
    }
}

-(void)callbackMethod:(NSString *)paramUrl
{
    
    if (self.QRCodeCallback) {
        self.QRCodeCallback(paramUrl);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - 属性设置
- (void)setQRCodeVideoFrame:(CGRect)QRCodeVideoFrame
{
    if (!CGRectContainsRect(_QRCodeVideoFrame, QRCodeVideoFrame)) {
        
        _QRCodeVideoFrame = QRCodeVideoFrame;
        if (self.captureSession.outputs.count) {
            if ([[self.captureSession.outputs firstObject] isKindOfClass:[AVCaptureMetadataOutput class]]) {
                AVCaptureMetadataOutput *captureMetadataOutput = [self.captureSession.outputs firstObject];
                captureMetadataOutput.rectOfInterest = [self setupRectOfInterest];
            }
        }
    }
}

@end
