//
//  KeychainHelper.h
//  Promise
//
//  Created by Barty Kim on 1/14/15.
//  Copyright (c) 2015 ZeroDesktop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeychainHelper : NSObject

+ (BOOL)saveWithKey:(NSString *)key andData:(NSData *)data;
+ (NSData *)loadWithKey:(NSString *)key;
+ (BOOL)deleteWithKey:(NSString *)key;
+ (BOOL)clear;

@end
