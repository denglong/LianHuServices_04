//
//  ShareWeCat.h
//  API_DEMO
//
//  Created by denglong on 4/25/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"

@interface ShareWeCat : NSObject

+ (void)initShareSDK;
+ (void)shareapplicationContent:(NSString *)content
                 defaultContent:(NSString *)defaultContentString
                          title:(NSString *)titleString
                            url:(NSString *)urlString
                    description:(NSString *)descriptionString
                           type:(ShareType)type
                      imagePath:(NSString *)imagePath;
+ (void)sharetextContent:(NSString *)content type:(ShareType)type;

/** 微信分享 */
+ (void)shareAction:(NSString *)kLinkTitle description:(NSString *)kLinkDescription linkUrl:(NSString *)kLinkURL shareType:(int)shareType;
/** QQ分享 */
+ (void)shareQQAction:(NSString *)linkTitle content:(NSString *)linkContent linkUrl:(NSString *)linkUrl;

@end
