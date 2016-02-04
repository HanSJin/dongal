//
//  NewsConnection.m
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import "Connection_API_POST.h"
#import "Constants.h"
#import "SingletonData.h"

@implementation Connection_API_POST

+ (NSData *)myConnection_api_post:(NSString *)connAPI connParam:(NSString *)connParam {
    // 제이슨 스트링 -> 포스트 데이터
    NSData *postData = [connParam dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
    //    NSLog(@"jsonData as string:\n%@", postData);
    
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", DONGAL_DOMAIN, connAPI];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    
    // request 작성
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    // HEADER - TOKEN
    SingletonData *sharedMan = [SingletonData sharedManager];
    [request addValue:sharedMan.UUID forHTTPHeaderField:@"TWENTY-ACCESS-TOKEN"];
    
    // response 생성
    NSHTTPURLResponse *response;
    NSError *error = nil;
    
    // 데이터 수신
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    int result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] intValue];
    
    // 에러 검사
    if (result == 0) {
        //        NSLog(@"Connect -> \"Succeess\" [POST : %@]", url);
    } else {
        NSLog(@"Connect -> \"Fail\" [result:%d, status:%d]", result, (int)[response statusCode]);
    }
    
    NSString *log = [NSString stringWithFormat:@"%@ \n\n", [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]];
    NSLog(log);
    
    return data;
}


@end
