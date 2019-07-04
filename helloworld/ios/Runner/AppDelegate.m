#include "AppDelegate.h"
#import <Flutter/Flutter.h>
#import "FTestVC.h"
#import "GeneratedPluginRegistrant.h"

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"samples.flutter.dev/battery"
                                            binaryMessenger:controller];
    
    __weak typeof(self) weakSelf = self;
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        if ([@"getBatteryLevel" isEqualToString:call.method]) {
            
//            int batteryLevel = [weakSelf getBatteryLevel];
//            if (batteryLevel == -1) {
//                result([FlutterError errorWithCode:@"UNAVAILABLE"
//                                           message:@"Battery info unavailable"
//                                           details:nil]);
//            } else {
//                result(@(batteryLevel));
//            }
            
//            UIButton *btn = [[UIButton alloc]init];
//            btn.frame = CGRectMake(10,100,100,100);
//            btn.backgroundColor = [UIColor whiteColor];
//
//            result(btn);
            
            UIAlertController *acontroller = [UIAlertController alertControllerWithTitle:@"title" message:@"msg" preferredStyle:UIAlertControllerStyleActionSheet];
            [acontroller addAction:[UIAlertAction actionWithTitle:@"A" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"==s=");
            }]];
            [acontroller addAction:[UIAlertAction actionWithTitle:@"B" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"==d=");
            }]];
            
            [acontroller addAction:[UIAlertAction actionWithTitle:@"B" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"=c==");
            }]];
            
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[[FTestVC alloc]init]];
            
            [controller presentViewController:navVC animated:true completion:nil];
            
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];

    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
    
    - (int)getBatteryLevel {
        UIDevice* device = UIDevice.currentDevice;
        device.batteryMonitoringEnabled = YES;
        if (device.batteryState == UIDeviceBatteryStateUnknown) {
            return -1;
        } else {
            return (int)(device.batteryLevel * 100);
        }
    }


@end
