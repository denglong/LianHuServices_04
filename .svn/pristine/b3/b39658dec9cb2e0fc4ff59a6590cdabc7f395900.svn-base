//
//  AGRequestData.m
//  AGConnectionNet
//
//  Created by 邓龙 on 16/1/17.
//  Copyright © 2016年 邓龙. All rights reserved.
//

#import "AGRequestData.h"
#import "XMLReader.h"

@implementation AGRequestData

+ (instancetype)shareRequestData{
    
    static AGRequestData *singleToken;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (singleToken == nil) {
            singleToken = [[AGRequestData alloc] init];
        }
    });
    return singleToken;
}


- (void)requestDataURL:(NSString *)URLStr parameters:(NSDictionary *)parameters method:(RequestMethod)method success:(void (^)(NSData *data , NSURLResponse *response))success fail:(void (^)(NSError *error))fail{
    
    NSURL *URL = nil;
    NSMutableURLRequest *request = nil;
    if (method == POST) {
        //判断 URL
        if (URLStr != nil) {
            URL = [NSURL URLWithString:URLStr];
            request = [NSMutableURLRequest requestWithURL:URL];
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"URL 错误!"}];
            fail(error);
            return;
        }
        request.HTTPMethod = @"POST";
        if (parameters != nil){
            NSString *parametersStr = [self NSDictionaryToNSString:parameters];
            NSData *bodyData = [parametersStr dataUsingEncoding:NSUTF8StringEncoding];
            request.HTTPBody = bodyData;
        }
    }else {
        //判断 URL
        if (URLStr != nil) {
            if (parameters != nil){
                NSMutableString *str = [NSMutableString stringWithFormat:@"%@?%@",URLStr,[self NSDictionaryToNSString:parameters]];
                URL = [NSURL URLWithString:str];
            }else {
                URL = [NSURL URLWithString:URLStr];
            }
            request = [NSMutableURLRequest requestWithURL:URL];
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"URL 错误!"}];
            fail(error);
            return;
        }
    }
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error == nil && data != nil){
            success(data,response);
        }else {
            fail(error);
        }
    }];
    [dataTask resume];
}


- (void)requestDataURL:(NSString *)URLStr parameters:(NSDictionary *)parameters method:(RequestMethod)method dataFormat:(DataFormat)format success:(void (^)( id data,NSURLResponse *response))success fail:(void (^)(NSError *))fail{
    
    [self requestDataURL:URLStr parameters:parameters method:method success:^(NSData *data, NSURLResponse *response) {
        id result = nil;
        if (format == JSON){
            NSError *error = nil;
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
            if (!error){
                success(result , response);
            }else {
                fail(error);
            }
        }else if (format == XML){
            NSError *error = nil;
            result = [XMLReader dictionaryForXMLData:data error:&error];
            if (!error){
                success(result , response);
            }else {
                fail(error);
            }
        }else {
            NSError *error = [NSError errorWithDomain:@"error" code:0 userInfo:@{@"error":@"返回数据类型错误!"}];
            fail(error);
            return;
        }
        
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark - 普通网络请求接口
- (void)requestDataMethParameters:(NSDictionary *)parameters
                success:(void (^)( id data,NSURLResponse *response))success fail:(void (^)(NSError *))fail{
    
    NSString *URLStr = [NSString stringWithFormat:API_URL];
    [self requestDataURL:URLStr parameters:parameters method:POST success:^(NSData *data, NSURLResponse *response) {
            NSError *error = nil;
            id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
            if (!error){
                success(result , response);
            }else {
                fail(error);
            }
    } fail:^(NSError *error) {
        fail(error);
    }];
}

#pragma mark - 管理员网络请求接口
- (void)requestDataMethodSystemParameters:(NSDictionary *)parameters
                                  success:(void (^)( id data,NSURLResponse *response))success
                                     fail:(void (^)(NSError *))fail {
    NSString *URLStr = [NSString stringWithFormat:API_URL_SYSTEM];
    [self requestDataURL:URLStr parameters:parameters method:POST success:^(NSData *data, NSURLResponse *response) {
        NSError *error = nil;
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
        if (!error){
            success(result , response);
        }else {
            fail(error);
        }
    } fail:^(NSError *error) {
        fail(error);
    }];
}


/**
 *  @author Ager, 2016-01-17
 *
 *  将 NSDictionary 装换为符合网络请求参数形势 NSString
 *
 *  @param dic 网络请求参数
 *
 *  @return 转换后字符串
 */
- (NSString *)NSDictionaryToNSString:(NSDictionary*)dic{
    
    NSMutableString *parametersStr = [NSMutableString string];
    for (NSString *key in dic ) {
        [parametersStr appendFormat:@"%@=%@&",key,[dic objectForKey:key]];
    }
    return [parametersStr substringToIndex:([parametersStr length] - 1)];
}

@end
