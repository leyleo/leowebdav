//
//  LEOWebDAVUploadRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-6.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVUploadRequest.h"
@interface LEOWebDAVUploadRequest ()
{
    NSData *_uploadData;
    NSString *_mimeType;
}
@end
@implementation LEOWebDAVUploadRequest

@synthesize data=_uploadData;
@synthesize dataMimeType=_mimeType;

-(id)initWithPath:(NSString *)thePath
{
    self=[super initWithPath:thePath];
    if(self){
        self.dataMimeType=@"application/octet-stream";
    }
    return self;
}

- (NSURLRequest *)request {
	NSParameterAssert(_uploadData != nil);
	
	NSString *len = [NSString stringWithFormat:@"%d", [_uploadData length]];
    NSLog(@"upload len:%@",len);
	
	NSMutableURLRequest *req = [self newRequestWithPath:self.path method:@"PUT"];
	[req setValue:self.dataMimeType forHTTPHeaderField:@"Content-Type"];
	[req setValue:len forHTTPHeaderField:@"Content-Length"];
	[req setHTTPBody:_uploadData];
	
	return req;
}

-(id)resultForData:(NSData *)data
{
    return data;
}
@end
