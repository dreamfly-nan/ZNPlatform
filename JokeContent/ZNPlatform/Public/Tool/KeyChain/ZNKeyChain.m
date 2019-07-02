//
//  KHKeyChain.m
//  networkTest
//
//  Created by 郑楠楠 on 2017/11/3.
//  Copyright © 2017年 郑楠楠. All rights reserved.
//

#import "ZNKeyChain.h"

@implementation ZNKeyChain
/**
 配置

 @param service <#service description#>
 @return <#return value description#>
 */
+ (NSMutableDictionary*) getKeychainQuery: (NSString*)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword, (id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock, (id)kSecAttrAccessible,nil];
}

+ (BOOL) save:(NSString*)service data:(id)data {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    return SecItemAdd((CFDictionaryRef)keychainQuery, NULL) == noErr;
}

+ (id) load:(NSString*)service {
    id ret = NULL;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    NSData *keyData = NULL;
    if(SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef*)(void*)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:keyData];
        }
        @catch (NSException *exception) {
            NSLog(@"Unarchive of %@ failed: %@", service, exception);
        }
        @finally {
        }
    }
    return ret;
}

+ (void) delete:(NSString*)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}
@end
