//
//  LEOWebDAVUtility.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-12-24.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEOWebDAVUtility : NSObject
+(LEOWebDAVUtility *)getInstance;
+(BOOL)isEmptyString:(NSString *)string;
-(NSString *)md5ForData:(NSData *)data;
+ (NSString *)formattedFileSize:(unsigned long long)size;
@end
