//
//  ShareWeCat.m
//  API_DEMO
//
//  Created by denglong on 4/25/16.
//  Copyright © 2016 邓龙. All rights reserved.
//

#import "ShareWeCat.h"
#import "OpenShareHeader.h"

#define SHARESDKKEY @"f705e83414c9"
#define WECHATAPPID @"wx2660f72f363a12de"

@interface ShareWeCat()
//{
//    id<ISSCAttachment> image;
//}
@end

@implementation ShareWeCat

/** 注册shareSDK分享 */
+ (void)initShareSDK {
    [ShareSDK registerApp: SHARESDKKEY];
    
    //微信好友
    [ShareSDK connectWeChatSessionWithAppId:WECHATAPPID
                                  wechatCls:[WXApi class]];
    
    //微信朋友圈
    [ShareSDK connectWeChatTimelineWithAppId:WECHATAPPID
                                   wechatCls:[WXApi class]];
    
    [OpenShare connectQQWithAppId:@"1105227419"];
}

/**
 * Method name: shareapplication
 * Description: 集成分享
 * Parameter: 传入要分享对应的参数
 content:分享的内容  defaultContent:默认内容  title:分享的标题 url:分享的链接 description:分享的描述
 type:要分享的平台   新浪微博 :ShareTypeSinaWeibo  微信好友:ShareTypeWeixiSession  微信朋友圈:ShareTypeWeixiTimeline QQ: ShareTypeQQ
 QQ空间:ShareTypeQQSpace            短信:ShareTypeSMS
 * Parameter: 无
 */
+ (void)shareapplicationContent:(NSString *)content
                 defaultContent:(NSString *)defaultContentString
                          title:(NSString *)titleString
                            url:(NSString *)urlString
                    description:(NSString *)descriptionString
                           type:(ShareType)type
                      imagePath:(NSString *)imagePath
{
    //[[CommClass sharedCommon]setObject:@"share" forKey:@"isShare"];
    id<ISSCAttachment> image = [ShareSDK imageWithUrl:imagePath];
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:defaultContentString
                                                image:image
                                                title:titleString
                                                  url:urlString
                                          description:descriptionString
                                            mediaType:SSPublishContentMediaTypeNews];
    
    //自定义UI分享
    [ShareSDK shareContent:publishContent
                      type:type
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            if (type == ShareTypeWeixiSession || type == ShareTypeWeixiTimeline) {
                                //[SRMessage infoMessage:[error errorDescription] delegate:self];
                            }else if (type == ShareTypeQQ ||type == ShareTypeQQSpace){
                                //[SRMessage infoMessage:[error errorDescription] delegate:self];
                            }
                        }
                        
                    }];
}

/**
 * Method name: sharetextContent
 * Description: 纯文字分享
 * Parameter:   传入要分享对应的参数
 content:分享的内容
 type:要分享的平台  新浪微博 :ShareTypeSinaWeibo  微信好友:ShareTypeWeixiSession  微信朋友圈:ShareTypeWeixiTimeline QQ: ShareTypeQQ
 QQ空间:ShareTypeQQSpace            短信:ShareTypeSMS
 * Parameter: 无
 */

+ (void)sharetextContent:(NSString *)content type:(ShareType)type
{
    //[[CommClass sharedCommon]setObject:@"share" forKey:@"isShare"];
    
    id<ISSContent> publishContent = [ShareSDK content:content
                                       defaultContent:nil
                                                image:nil
                                                title:nil
                                                  url:nil
                                          description:nil
                                            mediaType:SSPublishContentMediaTypeText];
    
    //自定义UI分享
    [ShareSDK shareContent:publishContent
                      type:type
               authOptions:nil
              shareOptions:nil
             statusBarTips:YES
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_SUC", @"发表成功"));
                        }
                        else if (state == SSPublishContentStateFail)
                        {
                            NSLog(NSLocalizedString(@"TEXT_SHARE_FAI", @"发布失败!error code == %d, error code == %@"), [error errorCode], [error errorDescription]);
                            if (type == ShareTypeWeixiSession || type == ShareTypeWeixiTimeline) {
                                //[SRMessage infoMessage:MY_25];
                            }else if (type == ShareTypeQQ ||type == ShareTypeQQSpace){
                                //[SRMessage infoMessage:MY_26];
                            }
                        }
                    }];
}

+ (void)shareAction:(NSString *)kLinkTitle description:(NSString *)kLinkDescription linkUrl:(NSString *)kLinkURL shareType:(int)shareType {
    
    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.bText = NO;//不使用文本信息
    sendReq.scene = shareType;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = kLinkTitle;//分享标题
    urlMessage.description = kLinkDescription;//分享描述
    [urlMessage setThumbImage:[UIImage imageNamed:@"icon"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = kLinkURL;//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
}

+ (void)shareQQAction:(NSString *)linkTitle content:(NSString *)linkContent linkUrl:(NSString *)linkUrl {
    UIImage *image = [UIImage imageNamed:@"icon"];
    NSData *imageData = UIImagePNGRepresentation(image);
    OSMessage *msg = [[OSMessage alloc] init];
    msg.title = linkTitle;
    msg.desc = linkContent;
    msg.image = imageData;
    msg.link = linkUrl;
    [OpenShare shareToQQFriends:msg Success:nil Fail:nil];
}

@end
