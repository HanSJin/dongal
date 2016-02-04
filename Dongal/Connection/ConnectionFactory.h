//
//  ConnectionFactory.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionFactory : NSObject

+ (NSData *)connType:(NSString *)connType connAPI:(NSString *)connAPI connParam:(NSString *)connParam;
@end
