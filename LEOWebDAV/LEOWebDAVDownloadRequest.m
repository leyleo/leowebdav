//
//  LEOWebDAVDownloadRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVDownloadRequest.h"

@implementation LEOWebDAVDownloadRequest
@synthesize item;
@synthesize dictionary;
@synthesize view;
@synthesize callback;
-(NSURLRequest *)request
{
//    NSParameterAssert(self.item != nil);
    
    NSMutableURLRequest *req=[self newRequestWithPath:self.path method:@"GET"];
	return req;
}

-(id)resultForData:(NSData *)data
{
    return data;
}
@end
