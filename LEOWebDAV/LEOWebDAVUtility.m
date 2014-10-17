//
//  LEOWebDAVUtility.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-12-24.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVUtility.h"
#import <CommonCrypto/CommonDigest.h>

#define LEO_MD5_DIGEST_LENGTH 16

@implementation LEOWebDAVUtility
+(LEOWebDAVUtility *)getInstance
{
    static LEOWebDAVUtility *_instance;
    @synchronized(self)
    {
        if(!_instance){
            _instance=[[LEOWebDAVUtility alloc] init];
        }
    }
    return _instance;
}

+(BOOL)isEmptyString:(NSString *)string
{
    if(!string)
    { //string is empty or nil
        return YES;
    }
    else if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        //string is all whitespace
        return YES;
    }
    return NO;
}

-(NSString *)md5ForData:(NSData *)data
{
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(data.bytes, data.length, md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

+ (NSString *)formattedFileSize:(unsigned long long)size
{
	NSString *formattedStr = nil;
    if (size == 0)
		formattedStr = NSLocalizedString(@"Empty",@"");
	else
		if (size > 0 && size < 1024)
			formattedStr = [NSString stringWithFormat:@"%qu bytes", size];
        else
            if (size >= 1024 && size < pow(1024, 2))
                formattedStr = [NSString stringWithFormat:@"%.1f KB", (size / 1024.)];
            else
                if (size >= pow(1024, 2) && size < pow(1024, 3))
                    formattedStr = [NSString stringWithFormat:@"%.2f MB", (size / pow(1024, 2))];
                else
                    if (size >= pow(1024, 3))
                        formattedStr = [NSString stringWithFormat:@"%.3f GB", (size / pow(1024, 3))];
	
	return formattedStr;
}

@end
