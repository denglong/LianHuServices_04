//
//  UITextView+JCExitKeyboard.m
//  keyborardHandle
//
//  Created by HJaycee on 16/4/11.
//  Copyright © 2016年 HJaycee. All rights reserved.
//

#import "UITextView+JCExitKeyboard.h"
#import "JCExitKeyboardToolBar.h"

@implementation UITextView (JCExitKeyboard)

- (void)willMoveToSuperview:(UIView *)newSuperview{
    JCExitKeyboardToolBar *toolBar = [JCExitKeyboardToolBar sharedKeyboardToolBar];
    toolBar.inputView = self;
    self.inputAccessoryView = toolBar;
}

@end
