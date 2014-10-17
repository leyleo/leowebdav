//
//  LEOWebDAVCopyRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-12.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVCopyRequest.h"

@interface LEOWebDAVCopyRequest ()
{
    NSString *_destinationPath;
    BOOL _overwrite;
}
@end
@implementation LEOWebDAVCopyRequest
@synthesize destinationPath=_destinationPath;
@synthesize overwrite=_overwrite;

- (NSString *)method {
	return @"COPY";
}

- (NSURLRequest *)request {
	NSParameterAssert(_destinationPath != nil);
	
    NSString *destPath=[self concatenatedURLWithPath:_destinationPath];
	
	NSMutableURLRequest *req = [self newRequestWithPath:self.path
												 method:[self method]];
	
	[req setValue:destPath forHTTPHeaderField:@"Destination"];
	
	if (_overwrite)
		[req setValue:@"T" forHTTPHeaderField:@"Overwrite"];
	else
		[req setValue:@"F" forHTTPHeaderField:@"Overwrite"];
	
	return req;
}

-(id)resultForData:(NSData *)data
{
    return data;
}
@end
