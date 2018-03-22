//
//  CloudClientRequest.m
//  KingProFrame
//
//  Created by JinLiang on 15/7/22.
//  Copyright (c) 2015年 king. All rights reserved.
//

#import "CloudClientRequest.h"
#import <CommonCrypto/CommonDigest.h>
#import "CommClass.h"
#import "JSONKit.h"
#import "DataCheck.h"
#import "MacroDefinitions.h"

@implementation CloudClientRequest
@synthesize delegate=_delegate;
@synthesize finishSelector=_finishSelector;
@synthesize finishErrorSelector=_finishErrorSelector;
@synthesize progressSelector=_progressSelector;


-(id)init
{
    self=[super init];
    if(self)
    {
        self.AFAppDotNetClient=[[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:CLOUD_API_URL]];
    }
    return self;
}


//检查服务器返回是否为空 no为空
BOOL TTIsStringWithAnyText(id object) {
    return [object isKindOfClass:[NSString class]] && [(NSString*)object length] > 0;
}


-(NSString*)getRequestUrl:(NSString*)mod parameter:(NSDictionary *)jsonDic{
    
//    //时间戳
//    NSString *timeStamp=[CommClass getCurrentTimeStamp];
//    
//    //NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
//    NSString *testUUID = [NSString stringWithFormat:@"eqbang_%@", [self getDeviceId]];
//    
//    NSString *clientVersion=[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
//    NSString *methodName=[NSString stringWithFormat:@"/%@",mod];
//    NSString *jsonString=@"{}";
//    if ([DataCheck isValidDictionary:jsonDic]) {
//        //change by jinliang  20150928
//        NSError *error;
//        NSData *jsonData=[NSJSONSerialization dataWithJSONObject:jsonDic
//                                                         options:kNilOptions
//                                                           error:&error];
//        jsonString=[[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
//        //end  change
//        
//    }
//    NSString *token =[[CommClass sharedCommon] objectForKey:LOGGED_TOKEN];
//    if (![DataCheck isValidString:token]) {
//        token = @"";
//    }
//    
//    NSString *imei = [[CommClass sharedCommon] objectForKey:@"deviceToken"];
//    if (![DataCheck isValidString:imei]) {
//        imei = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
//    }
//    NSString *md5Str=[CommClass md5:[NSString stringWithFormat:@"%@%@%@%@%@%@",timeStamp,testUUID,clientVersion,methodName,jsonString, imei]];
    
    NSString *requestUrl= [NSString stringWithFormat:@"%@%@", CLOUD_API_URL, mod];//[NSString stringWithFormat:@"%@%@?t=%@&token=%@&uuid=%@&vid=%@&sign=%@&imei=%@&nt=wifi&cid=dev&business=1",CLOUD_API_URL,mod,timeStamp,token,testUUID,clientVersion,md5Str,imei];
    
    return requestUrl;
}

/**
 *  普通的网络请求
 *
 *  @param url        请求链接
 *  @param postParam  请求参数
 *  @param block      成功回掉
 *  @param blockError 失败回掉
 */
-(void)callMethodWithMod:(NSString *)mod
              parameters:(NSDictionary *)parameters
                delegate:(id)delegate
                 succeed:(SEL)succeedSel
                 failure:(SEL)errorSel
        progressSelector:(SEL)progressSel
           statusMessage:(NSString *)loadingMessage
{
    
    
    NSString *requestUrl=[self getRequestUrl:mod parameter:parameters];
    
    CloudClientRequest *cloudRequestPost=[[CloudClientRequest alloc] init];
    
    [cloudRequestPost setconManagefiguration];
    
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     delegate, @"delegate",
                                     NSStringFromSelector(succeedSel),  @"selector",
                                     NSStringFromSelector(errorSel),    @"errorSelector",
                                     NSStringFromSelector(progressSel), @"progressSelector",
                                     nil];
    
    [cloudRequestPost.AFAppDotNetClient POST:requestUrl
                                  parameters:parameters
                                     success:^(NSURLSessionDataTask *task, id responseObject) {
                                         @try {
                                             if ([DataCheck isValidDictionary:responseObject]) {
                                                 
                                                 NSDictionary *resultDic=[NSDictionary dictionaryWithDictionary:responseObject];
                                                 
                                                 int code=[[resultDic objectForKey:@"code"] intValue];
                                                 NSString *message = [resultDic objectForKey:@"msg"];
                                                 
                                                 if (code != 0 ) {
                                                     NSDictionary *errorInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                                [NSString stringWithFormat:@"%d", code], @"code",
                                                                                message, @"msg", nil];
                                                     
                                                     [_delegate performSelector:_finishErrorSelector
                                                                     withObject:userInfo
                                                                     withObject:errorInfo];
                      
                                                     
                                                     return;
                                                 }
                                                 
                                                 
                                                 [_delegate performSelector:_finishSelector
                                                                 withObject:userInfo
                                                                 withObject:[resultDic objectForKey:@"data"]];
                                                 
                                             }
                                         }
                                         @catch (NSException *exception) {
                                             
                                         }
                                         
                                     }
                                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         //DLog(@"%@",error);
                                     }];
    
}


#pragma mark------------------------------------配置------------------------------------------------------
/**
 *  AFHTTPSessionManager 配置
 */
-(void)setconManagefiguration
{
    
    
    self.AFAppDotNetClient.requestSerializer = [AFJSONRequestSerializer serializer];
    
    self.AFAppDotNetClient.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [self.AFAppDotNetClient.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Accept"];
    
    [self.AFAppDotNetClient.requestSerializer setValue:@"application/json"forHTTPHeaderField:@"Content-Type"];
    
    [self.AFAppDotNetClient.requestSerializer setTimeoutInterval:30];
    
}


@end
