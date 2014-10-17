//
//  LEOWebDAVClient.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>
@class LEOWebDAVBaseRequest;

@interface LEOWebDAVClient : NSObject
{
}

@property(strong,readonly) NSURL *rootURL;
@property(strong,readonly) NSString *userName;
@property(strong,readonly) NSString *password;
@property(assign) BOOL allowUntrusedCertificate;

@property(readonly) NSUInteger requestCount;
@property(assign) NSInteger maxRequestsCount;

-(id)initWithRootURL:(NSURL *)url andUserName:(NSString *)name andPassword:(NSString*)password;
-(void)setupRootURL:(NSURL *)url
        andUserName:(NSString *)name
        andPassword:(NSString*)password;
-(void)enqueueRequest:(LEOWebDAVBaseRequest*)enRequest;
-(void)cancelRequest;
-(void)cancelDelegate;
-(NSArray *)currentArray;
@end
