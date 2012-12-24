//
//  LEOWebDAVBaseRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEOWebDAVBaseRequest : NSOperation
@property(strong) NSURL *rootURL;
@property(strong) NSString *userName;
@property(strong) NSString *password;
@property(assign) BOOL allowUntrusedCertificate;
@end
