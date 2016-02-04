//
//  NewsConnection.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection_API_GET : NSObject

+ (NSData *)myConnection_api_get:(NSString *)connAPI connParam:(NSString *)connParam;

@end
