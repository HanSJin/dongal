//
//  NewsConnection.m
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import "Connection_API_GET.h"
#import "SingletonData.h"
#import "Constants.h"

@implementation Connection_API_GET

+ (NSData *)myConnection_api_get:(NSString *)connAPI connParam:(NSString *)connParam {
    NSString *param = [connParam stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@", TWENTY_DOMAIN, connAPI, param];
    NSLog(urlStr);
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // request 작성
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPMethod:@"GET"];
    
    // HEADER - TOKEN
    SingletonData *sharedMan = [SingletonData sharedManager];
    [request addValue:sharedMan.UUID forHTTPHeaderField:@"TWENTY-ACCESS-TOKEN"];
    
    // response 생성
    NSHTTPURLResponse *response;
    NSError *error;
    
    // 데이터 수신
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    int result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] intValue];

    // 에러 검사
    if (result == 0) {
        // NSLog(@"Connect -> \"Succeess\" [GET :%@]", url);
    } else {
        NSLog(@"Connect -> \"Fail\" [result:%d, status:%d]", result, (int)[response statusCode]);
    }
    NSString *log = [NSString stringWithFormat:@"%@ \n\n", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]];
    NSLog(log);
    
    return data;
}


@end
