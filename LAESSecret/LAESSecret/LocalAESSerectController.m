//
//  LocalAESSerectController.m
//  LAESSecret
//
//  Created by 李昊泽 on 16/9/9.
//  Copyright © 2016年 李昊泽. All rights reserved.
//

#import "LocalAESSerectController.h"
#import "GTMBase64.h"
#import "AESCryptor.h"
@interface LocalAESSerectController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cryptorTextField;
@property (weak, nonatomic) IBOutlet UITextView *showTextView;
/** 被加密的数据  */
@property (nonatomic, copy) NSString *encryptStr;
/** AES密钥  */
@property (nonatomic, strong) NSData *AES128;
@end

@implementation LocalAESSerectController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cryptorTextField.delegate = self;
}

#pragma mark - AESSerect
//加密
- (IBAction)encrypt:(id)sender {
    self.encryptStr = nil;
    
    if ([self.cryptorTextField.text isEqualToString:@""]) {
        [self addLogString:@"请输入加密的数据"];
    } else {
        //base64编码
        NSData *encryptData = [AESCryptor AES128EncryptWithKey:self.AES128 data:[self.cryptorTextField.text dataUsingEncoding:NSUTF8StringEncoding]];
        
        //AES加密
        NSString *encryptStr = [encryptData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        
        self.encryptStr = encryptStr;
        [self addLogString:[NSString stringWithFormat:@"加密后的数据   %@", encryptStr]];
    }
}

//解密encryptData
- (IBAction)decrypt:(id)sender {
    if (!self.encryptStr) {
        [self addLogString:@"请先加密数据"];
    } else {
        //Base64解码  请选取正确的base64解码方式 具体请看http://www.jianshu.com/p/db85399e8a76
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:self.encryptStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        //AES解密
        NSData *decryptData = [AESCryptor AES128DecryptWithKey:self.AES128 data:decodeData];
        
        //转UTF8字符串
        NSString *decryptStr = [[NSString alloc] initWithData:decryptData encoding:NSUTF8StringEncoding];
        
        [self addLogString:[NSString stringWithFormat:@"解密后的数据   %@", decryptStr]];
    }
}

#pragma mark - Selector
- (void)addLogString:(NSString *)logString
{
    NSString *preLogStr = self.showTextView.text;
    NSString *additionStr = [logString stringByAppendingString:@"\n\n"];
    if (preLogStr) {
        self.showTextView.text = [additionStr stringByAppendingString:preLogStr];
    } else {
        self.showTextView.text = logString;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    return YES;
}

#pragma mark - 
- (NSData *)AES128
{
    if (!_AES128) {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        _AES128 = [userDefault objectForKey:@"AES128KEY"];
    }
    return _AES128;
}
@end
