#import <Foundation/Foundation.h>

@interface AESCryptor : NSObject

+(NSData*) generateRandom128BitAESKey;

+(NSData *) AES128EncryptWithKey:(NSData *)key data:(NSData*)data;

+(NSData *) AES128DecryptWithKey:(NSData *)key data:(NSData*)data;

@end
