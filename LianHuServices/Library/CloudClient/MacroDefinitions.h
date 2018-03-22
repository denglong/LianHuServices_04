//
//  MacroDefinitions.h
//  KingProFrame
//
//  Created by JinLiang on 15/6/26.
//  Copyright (c) 2015年 king. All rights reserved.
//

//线上环境
#define API_URL       @"https://zw.lianhu.gov.cn/phone_interface2.jsp"//@"http://www.lhkfb.gov.cn/"

////99$个推key
//#define kAppId           @"isDPen5QgbAETqOO2cQfo1"
//#define kAppKey          @"JjAaLsjNkV7GvySQqkaBE7"
//#define kAppSecret       @"Dwe305vWzq54iITSsbHzw4"

//ShareSDK 的 key
#define ShareSDK_Key    @"f705e83414c9"
//微信分享的key
#define WeiXi_Key       @"wxd418d2a3dd2f9546"

//QQ分享的key
#define QQ_Key          @"1105189472"
//QQappSecret
#define QQ_appSecret    @"EQ0H1e9cAAEk2hzr"


//应用的内部版本号 对应的是build
#define APP_CLIENT_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//上传到AppStore上面的版本号 对应的是version
#define AppStore_VERSION [[NSBundle mainBundle]   objectForInfoDictionaryKey:@"CFBundleShortVersionString"]

//最终的url
#define CLOUD_API_URL     [NSString stringWithFormat:@"%@",API_URL]
#define viewWidth [UIScreen mainScreen].bounds.size.width
#define kViewHeight [UIScreen mainScreen].bounds.size.height

//定义RGBA 颜色快捷方法
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

//设置图片
#define UIIMAGE(X) [UIImage imageNamed:(X)]

#define IOS7 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0)
#define IOS8 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0)
#define IOS9 ([[[UIDevice currentDevice]systemVersion] floatValue] >= 9.0)


#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Ps ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) : NO)

