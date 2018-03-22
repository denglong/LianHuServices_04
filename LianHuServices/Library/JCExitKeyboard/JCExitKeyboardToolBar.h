//
//  JCExitKeyboardToolBar.h
//  keyborardHandle
//
//  Created by HJaycee on 16/4/11.
//  Copyright © 2016年 HJaycee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JCExitKeyboardToolBar : UIImageView

@property (nonatomic, weak) UIView *inputView;

+ (instancetype)sharedKeyboardToolBar;

@end
