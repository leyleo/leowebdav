//
//  LEOContentTypeConvert.m
//  ConnectDisk
//
//  Created by Liu Ley on 12-11-1.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOContentTypeConvert.h"
#import "LEOWebDAVUtility.h"

static NSString *const kExtentToMIMEPlistFileName   =   @"extentToMIME.plist";

@interface LEOExtensionToMIME ()
-(id)init;
@end

@implementation LEOExtensionToMIME
-(id)init
{
    self=[super init];
    if (self) {
        NSString *filePath=[[[NSBundle mainBundle] bundlePath] stringByAppendingFormat:@"%@",kExtentToMIMEPlistFileName];
        _convertDic=[[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    }
    return self;
}

+(LEOExtensionToMIME *)getInstance
{
    static LEOExtensionToMIME *_instance;
    @synchronized(self)
    {
        if(!_instance){
            _instance=[[LEOExtensionToMIME alloc] init];
        }
    }
    return _instance;
}

-(NSString *)searchMimeFromExtension:(NSString *)extension
{
    NSString *result=[_convertDic valueForKey:extension];
    return result;
}
@end