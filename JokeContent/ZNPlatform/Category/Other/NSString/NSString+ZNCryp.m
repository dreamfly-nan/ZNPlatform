//
//  NSString+ZNCryp.m
//  ZNNavigationViewController
//
//  Created by 郑楠楠 on 2018/4/26.
//  Copyright © 2018年 郑楠楠. All rights reserved.
//

#import "NSString+ZNCryp.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "GTMBase64.h"

@implementation NSString (ZNCryp)

+ (NSString*)zn_md5:(NSString *)input{
    const char *cSt = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cSt, strlen(cSt), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",digest[i]];
    }
    return output;
}

/**
 DES加密
 @return <#return value description#>
 */
- (NSString*)zn_InDESWithKey:(NSString*)key{
    NSString *ciphertext = nil;
    const char *textBytes = [self UTF8String];

    NSUInteger dataLength = [self length];
    
    unsigned char buffer[1024 * 500];
    
    memset(buffer, 0, sizeof(char));
    
//    Byte iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF };
    //注:iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF }为移动端和后台约定的字段
    
    Byte *iv = (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    size_t numBytesEncrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String], kCCKeySizeDES,
                                          iv,
                                          textBytes, dataLength,
                                          buffer, 1024 * 500,
                                          &numBytesEncrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
    }
    return ciphertext;
}

/**
 DES解密
 @return <#return value description#>
 */
- (NSString*)zn_OutDESWithKey:(NSString *)key{
    NSData* cipherData = [GTMBase64 decodeString:self];
    unsigned char buffer[1024 * 500];
    memset(buffer, 0, sizeof(char));
    size_t numBytesDecrypted = 0;
    
//    Byte iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF };
    //注:iv[] = { 0x12, 0x34, 0x56, 0x78,  0x90,  0xAB,  0xCD,  0xEF }为移动端和后台约定的字段
    
    Byte *iv = (Byte *)[[key dataUsingEncoding:NSUTF8StringEncoding] bytes];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmDES,
                                          kCCOptionPKCS7Padding|kCCOptionECBMode,
                                          [key UTF8String],
                                          kCCKeySizeDES,
                                          iv,
                                          [cipherData bytes],
                                          [cipherData length],
                                          buffer,
                                          1024 * 500,
                                          &numBytesDecrypted);
    NSString* plainText = nil;
    if (cryptStatus == kCCSuccess) {
        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return plainText;
}

@end
