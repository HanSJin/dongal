//
//  KeychainHelper.m
//  Promise
//
//  Created by Barty Kim on 1/14/15.
//  Copyright (c) 2015 ZeroDesktop. All rights reserved.
//

#import "KeychainHelper.h"

@implementation KeychainHelper

+ (BOOL)saveWithKey:(NSString *)key andData:(NSData *)data
{
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecValueData : data};
    SecItemDelete((__bridge CFDictionaryRef)(query));
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)(query), nil);
    
    return status == noErr;
}

+ (NSData *)loadWithKey:(NSString *)key
{
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge NSString *)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount : key,
                            (__bridge id)kSecReturnData : @YES,
                            (__bridge id)kSecMatchLimit : (__bridge id)kSecMatchLimitOne};
    
    CFTypeRef dataTypeRef = nil;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), &dataTypeRef);
    
    if (status == noErr)
    {
        return ( __bridge_transfer NSData *)dataTypeRef;
    }
    
    return nil;
}

+ (BOOL)deleteWithKey:(NSString *)key
{
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword,
                            (__bridge id)kSecAttrAccount : key};
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
    
    return status == noErr;
}

+ (BOOL)clear
{
    NSDictionary *query = @{(__bridge id)kSecClass : (__bridge id)kSecClassGenericPassword};
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)(query));
    
    return status == noErr;
}

@end
