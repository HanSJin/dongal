//
//  ConnectionFactory.m
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import "ConnectionFactory.h"
#import "Connection_API_GET.h"
#import "Connection_API_POST.h"
#import "Constants.h"

@implementation ConnectionFactory

// 팩토리 수정됨.
+ (NSData *)connType:(NSString *)connType connAPI:(NSString *)connAPI connParam:(NSString *)connParam {
    
    NSLog(@"[ConnectionFactory] \n@@@ connType:\t\t\t[%@] \n@@@ connAPI:\t\t\t[%@] \n@@@ connParam:\t\t\t[%@]", connType, connAPI, connParam);
    
    if ([connType isEqualToString:@"GET"]) {
        return [Connection_API_GET myConnection_api_get:connAPI connParam:connParam];
    }
    
    
    else if ([connType isEqualToString:@"POST"]) {
        return [Connection_API_POST myConnection_api_post:connAPI connParam:connParam];
    }
    
    
    else if ([connType isEqualToString:@"DELETE"]) {
    }
    
    
    
    
    return nil;
}
@end
