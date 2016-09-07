#import "AESCryptor.h"

#import <CommonCrypto/CommonCryptor.h>
#import "NSData+Random.h"

// https://github.com/Gurpartap/AESCrypt-ObjC



@implementation AESCryptor


#pragma mark -

+(NSData*) generateRandom128BitAESKey
{
    return [NSData random: kCCKeySizeAES128];
}


+(NSData *) AES128EncryptWithKey:(NSData*)key data:(NSData*)data
{
    return [self doCipher:data iv:nil key:key context:kCCEncrypt error:nil];
}


+(NSData *) AES128DecryptWithKey:(NSData*)key data:(NSData*)data
{
    return [self doCipher:data iv:nil key:key context:kCCDecrypt error:nil];
}






// http://stackoverflow.com/questions/13490716/ios-aes-wrong-implemetation/13490717#13490717
// http://stackoverflow.com/questions/23637597/ios-aes-encryption-fail-to-encrypt/23641521#23641521
 
+ (NSData *)doCipher:(NSData *)dataIn
                  iv:(NSData *)iv
                 key:(NSData *)symmetricKey
             context:(CCOperation)encryptOrDecrypt
               error:(NSError **)error
{
    CCCryptorStatus ccStatus   = kCCSuccess;
    size_t          cryptBytes = 0;
    NSMutableData  *dataOut    = [NSMutableData dataWithLength:dataIn.length + kCCBlockSizeAES128];
    
    ccStatus = CCCrypt( encryptOrDecrypt,
                       kCCAlgorithmAES,
                       kCCOptionECBMode | kCCOptionPKCS7Padding,
                       symmetricKey.bytes,
                       symmetricKey.length,
                       iv.bytes,
                       dataIn.bytes,
                       dataIn.length,
                       dataOut.mutableBytes,
                       dataOut.length,
                       &cryptBytes);
    
    if (ccStatus == kCCSuccess) {
        dataOut.length = cryptBytes;
    }
    else {
        if (error) {
            *error = [NSError errorWithDomain:@"kEncryptionError"
                                         code:ccStatus
                                     userInfo:nil];
        }
        dataOut = nil;
    }
    
    return dataOut;
}



@end
