//
//  SRMessage.m
//  Discuz2
//
//  Created by rexshi on 6/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SRMessage.h"
#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0)
@implementation SRMessage

+ (void) errorMessage:(NSString *)message
{
    [self errorMessage:message delegate:nil];
}

+ (void) errorMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"错误"
                                                     message:message
                                                    delegate:delegate
                                           cancelButtonTitle:@"确定"
                                           otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void) successMessage:(NSString *)message
{
    [self successMessage:message delegate:nil];
}

+ (void) successMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功"
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void)infoMessage:(NSString *)message clickStr:(NSString *)clickStr {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:clickStr
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void) infoMessage:(NSString *)message
{
    [self infoMessage:message delegate:nil];
}

+ (void)infoMessage:(NSString *)title message:(NSString *)message block:(void (^)())block back:(void (^)())backBlock
{
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = @"返回";
    cancelItem.action = backBlock;
    RIButtonItem *buttonItem = [RIButtonItem item];
    buttonItem.label = @"确定";
    buttonItem.action = block;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:buttonItem,nil];
    [alertView show];
    [alertView release];
}

+ (void)orderBusinessMessage:(NSString *)message block:(void (^)())block
{
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = @"返回,联系用户";
    cancelItem.action = ^{};
    RIButtonItem *buttonItem = [RIButtonItem item];
    buttonItem.label = @"已协商,确定取消";
    buttonItem.action = block;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                        message:message
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:buttonItem,nil];
    [alertView show];
    [alertView release];
}

+ (void)loginInfoMessage:(NSString *)message block:(void (^)())block
{
    RIButtonItem *buttonItem = [RIButtonItem item];
    buttonItem.label = @"确定";
    buttonItem.action = block;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                        message:message
                                               cancelButtonItem:nil
                                               otherButtonItems:buttonItem,nil];
    [alertView show];
    [alertView release];
}

+ (void)infoMessageOk:(NSString *)message block:(void (^)())block
{
    RIButtonItem *cancelItem = [RIButtonItem item];
    cancelItem.label = @"返回";
    cancelItem.action = ^{};
    RIButtonItem *buttonItem = [RIButtonItem item];
    buttonItem.label = @"拨打";
    buttonItem.action = block;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                        message:message
                                               cancelButtonItem:cancelItem
                                               otherButtonItems:buttonItem,nil];
    [alertView show];
    [alertView release];
}

+ (void) infoMessageWithTitle:(NSString *)title message:(NSString *)message
{
    [self infoMessageWithTitle:title message:message delegate:nil];
}

+ (void) infoMessage:(NSString *)message delegate:(id)delegate
{
    if (IOS9) {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil
                                                                                  message:message
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [delegate presentViewController:alertController animated:YES completion:nil];
       
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(remove:) userInfo:alertController repeats:NO];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:nil//@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(remove:) userInfo:alert repeats:NO];
}
}


+ (void) infoMessageWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示!"
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}

+ (void)myInfoMessage:(NSString *)message delegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"去看看", nil];
    [alert show];
    [alert release];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(removeApp:) userInfo:alert repeats:NO];
}

+(void)remove:(NSTimer *)timer
{
    if (IOS9) {
        UIAlertController * alert = [timer userInfo];
        [alert dismissViewControllerAnimated:NO completion:nil];
    }else{
        UIAlertView *alert=[timer userInfo];
        [alert dismissWithClickedButtonIndex:0 animated:NO];
    }
}

+(void)removeApp:(NSTimer *)timer
{
    UIAlertView *alert=[timer userInfo];
    [alert dismissWithClickedButtonIndex:0 animated:NO];
}

+ (UIActionSheet *)actionSheet{
    RIButtonItem *btn1 = [RIButtonItem itemWithLabel:@"取消"];
    RIButtonItem *btn2 = [RIButtonItem itemWithLabel:@"微信好友"];
    RIButtonItem *btn3 = [RIButtonItem itemWithLabel:@"微信朋友圈"];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil cancelButtonItem:btn1 destructiveButtonItem:nil otherButtonItems:btn2, btn3, nil];
    return actionSheet;
}

@end
