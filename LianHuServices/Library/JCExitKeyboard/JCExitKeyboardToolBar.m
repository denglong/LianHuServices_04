//
//  JCExitKeyboardToolBar.m
//  keyborardHandle
//
//  Created by HJaycee on 16/4/11.
//  Copyright © 2016年 HJaycee. All rights reserved.
//

#import "JCExitKeyboardToolBar.h"

@interface JCExitKeyboardToolBar ()

@property (nonatomic, strong) NSMutableArray *inputViews;

+ (instancetype)sharedKeyboardToolBar;

@end

@implementation JCExitKeyboardToolBar

+ (instancetype)sharedKeyboardToolBar{
    static JCExitKeyboardToolBar *shareSingleTonInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareSingleTonInstance = [JCExitKeyboardToolBar new];
        [shareSingleTonInstance setup];
    });
    return shareSingleTonInstance;
}

- (void)setup{
    self.userInteractionEnabled = YES;
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat width = 40;
    CGFloat height = 40;
    self.image = [UIImage imageNamed:@"JCExitKeyboard.bundle/toolbar_bg"];
    self.frame = CGRectMake(0, 0, screenWidth, height);
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [self addSubview:line];
    
    UIButton *exitBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenWidth - width, 0, width, height)];
    [exitBtn setImage:[UIImage imageNamed:@"JCExitKeyboard.bundle/exit"] forState:UIControlStateNormal];
    [exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:exitBtn];
}

- (void)exitBtnClick{
    [self.inputViews makeObjectsPerformSelector:@selector(resignFirstResponder)];
}

- (void)setInputView:(UIView *)inputView{
    _inputView = inputView;
    if (!self.inputViews) {
        self.inputViews = [NSMutableArray array];
    }
    [self.inputViews addObject:inputView];
}

@end
