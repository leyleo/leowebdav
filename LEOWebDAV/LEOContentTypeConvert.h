//
//  LEOContentTypeConvert.h
//  ConnectDisk
//
//  Created by Liu Ley on 12-11-1.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEOExtensionToMIME : NSObject
{
    NSMutableDictionary *_convertDic;
}
+(LEOExtensionToMIME *)getInstance;
-(NSString *)searchMimeFromExtension:(NSString *)extension;
@end