//
//  KKDatePickerView.h
//  PickerView
//
//  Created by mac on 16/4/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KKDatePickerViewModel.h"

@protocol CustomAlertDelegete <NSObject>

-(void)btnindex:(KKDatePickerViewModel *)model show:(BOOL)show;

@end

@interface KKDatePickerView : UIView

@property (strong, nonatomic) UIPickerView *pickerView;
@property (nonatomic, strong)KKDatePickerViewModel *model;
@property (nonatomic,retain) id<CustomAlertDelegete> delegate;

-(instancetype)initWithFrame:(CGRect)frame;
@end
