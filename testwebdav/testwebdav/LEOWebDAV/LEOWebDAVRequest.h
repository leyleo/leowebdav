//
//  LEOWebDAVRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVBaseRequest.h"

@protocol LEOWebDAVRequestDelegate;

@interface LEOWebDAVRequest : LEOWebDAVBaseRequest
{}

@property(strong,readonly) NSString *path;
@property(strong,readonly) NSString *relativePath;
@property(assign) id<LEOWebDAVRequestDelegate> delegate;
@property(assign) id instance;
@property(assign) SEL errorAction;
@property(assign) SEL successAction;
@property(assign) SEL receiveAction;
@property(assign) SEL startAction;

-(id)initWithPath:(NSString *)thePath;
-(NSURLRequest *)request;
-(id)resultForData:(NSData *)data;
- (NSMutableURLRequest *)newRequestWithPath:(NSString *)path method:(NSString *)method;
-(NSString *)concatenatedURLWithPath:(NSString *)thePath;
@end

@protocol LEOWebDAVRequestDelegate <NSObject>
- (void)request:(LEOWebDAVRequest *)request didFailWithError:(NSError *)error;
- (void)request:(LEOWebDAVRequest *)request didSucceedWithResult:(id)result;
@optional
- (void)requestDidBegin:(LEOWebDAVRequest *)request;
- (void)request:(LEOWebDAVRequest *)request didReceivedProgress:(float)percent;
- (void)request:(LEOWebDAVRequest *)request didSendBodyData:(NSUInteger)percent;
@end