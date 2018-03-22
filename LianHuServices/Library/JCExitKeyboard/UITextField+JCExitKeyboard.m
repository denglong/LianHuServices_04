//
//  UITextField+JCExitKeyboard.m
//  keyborardHandle
//
//  Created by HJaycee on 16/4/11.
//  Copyright © 2016年 HJaycee. All rights reserved.
//

#import "UITextField+JCExitKeyboard.h"
#import "JCExitKeyboardToolBar.h"

@implementation UITextField (JCExitKeyboard)

- (void)willMoveToSuperview:(UIView *)newSuperview{
    JCExitKeyboardToolBar *toolBar = [JCExitKeyboardToolBar sharedKeyboardToolBar];
    toolBar.inputView = self;
    self.inputAccessoryView = toolBar;
}

@end
