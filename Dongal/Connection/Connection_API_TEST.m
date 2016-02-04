//
//  NewsConnection.m
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import "Connection_API_TEST.h"
#import "Constants.h"

@implementation Connection_API_TEST

+ (NSData *)myConnection_test:(NSString *)connectionType connectionParam:(NSString *)connectionParam {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@", TWENTY_DOMAIN, connectionType];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // request 작성 - GET
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//    [request setURL:url];
//    [request setCachePolicy:NSURLRequestUseProtocolCachePolicy];
//    [request setHTTPMethod:@"GET"];
    
    // request 작성 - POST
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];
//    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    [request setHTTPBody:postData];
    
//    [request setHTTPBody:[post dataUsingEncoding:NSUTF8StringEncoding]];
    
    // response 생성
    NSHTTPURLResponse *response;
    NSError *error;
    
    // 데이터 수신
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    int result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] intValue];
    
    // 에러 검사
    if (result == 0) {
                NSLog(@"Connect -> \"Succeess\" : %@", urlStr);
    } else {
        NSLog(@"Connect -> \"Fail\" [result:%d, status:%d]", result, (int)[response statusCode]);
    }
    
    NSLog([[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
    
    return data;
}


@end
