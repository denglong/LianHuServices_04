
//
//  TempViewController.m
//  QRCode_Demo
//
//  Created by 沈红榜 on 15/11/17.
//  Copyright © 2015年 沈红榜. All rights reserved.
//

#import "TempViewController.h"
#import "SHBQRView.h"
#import "RootViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import "GeneralShowWebView.h"
#import "AGRequestData.h"
#import "SRMessage.h"
#import "LianHuServices-swift.h"

#define iPhone5ORiPhone5c ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface TempViewController ()<SHBQRViewDelegate,UINavigationControllerDelegate>
{
    SHBQRView *qrView;
}
@end

@implementation TempViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

-(void)dealloc
{
  [qrView stopScan];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"扫描二维码";
    
    qrView = [[SHBQRView alloc] initWithFrame:self.view.bounds];
    qrView.delegate = self;
    [qrView initView];
    [self.view addSubview:qrView];
    qrView.center = CGPointMake(self.view.center.x, qrView.center.y);
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, qrView.center.y+110+20, 375, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:14];
    label.text = @"将二维码放入框内 , 即可自动扫描";
    [self.view insertSubview:label aboveSubview:qrView];
    label.center = CGPointMake(self.view.center.x, label.center.y);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIImage *backImg = [UIImage imageNamed:@"back_icon"];
    backImg = [backImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [button setImage:backImg forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBtn;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)qrView:(SHBQRView *)view ScanResult:(NSString *)result {
    [view stopScan];
      NSLog(@"%@",[NSString stringWithFormat:@"扫描结果：%@", result]);
    
    if (self.isHome == YES) {
        GeneralWebController *general = [[GeneralWebController alloc] initWithNibName:@"GeneralWebController" bundle:nil];
        general.title = @"办件查询";
        general.urlStr = [NSString stringWithFormat:@"https://zw.lianhu.gov.cn/usexzsp/phone_interface2.jsp?action_type=event_proc&e_code=%@",result];
        [self.navigationController pushViewController:general animated:YES];
        return;
    }
    
    [view stopScan];
    NSDictionary *params = @{@"action_type":@"call_wait", @"code":result};
    [[AGRequestData shareRequestData] requestDataMethodSystemParameters:params success:^(NSDictionary *data, NSURLResponse *response) {
        
        NSLog(@"%@", data);
        dispatch_async(dispatch_get_main_queue(), ^{
            [SRMessage loginInfoMessage:[NSString stringWithFormat:@"等待办件人数: %@", data[@"count"]] block:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        });
        
    } fail:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
    
//    if ([result isEqualToString:@"-400"]) {
//         //[SRMessage infoMessage:@"打开摄像头失败" delegate:self];
//    }
//    NSString * result1 = [result lowercaseString];
//    if ([result1 hasPrefix:@"http://"] || [result1 hasPrefix:@"https://"]) {
//        NSRange rang1 =[result1 rangeOfString:@".eqbangcdn.com"];
//         NSRange rang2 =[result1 rangeOfString:@".eqbang.com"];
//         NSRange rang3 =[result1 rangeOfString:@".eqbang.cn"];
//        if (rang1.location != NSNotFound || rang2.location != NSNotFound || rang3.location != NSNotFound) {
////            GeneralShowWebView * generalShowWebView = [[GeneralShowWebView alloc]init];
////            generalShowWebView.advUrlLink = result;
////            [self.navigationController pushViewController:generalShowWebView animated:YES];
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSMutableArray * viewControlers = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
//                [viewControlers removeObject:self];
//                self.navigationController.viewControllers = [NSArray arrayWithArray:viewControlers];
//            });
//        }else{
//          //非正确连接跳转系统默认的浏览器
//            NSURL *url = [NSURL URLWithString:result];
//            [[UIApplication sharedApplication] openURL:url];
//            [self.navigationController popToRootViewControllerAnimated:NO];
//        }
//    }else{
////        [SRMessage infoMessage:@"请扫描二维码" delegate:self];
//        [view startScan];
//    }
}

@end
