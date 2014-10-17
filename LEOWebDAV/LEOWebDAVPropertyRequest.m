//
//  LEOWebDAVPropertyRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVPropertyRequest.h"
#import "LEOWebDAVDefines.h"
#import "LEOWebDAVParser.h"
#import "LEOWebDAVItem.h"

@interface LEOWebDAVPropertyRequest ()
{
    NSUInteger _depth;
}
@end

@implementation LEOWebDAVPropertyRequest

- (id)initWithPath:(NSString *)aPath {
	self = [super initWithPath:aPath];
	if (self) {
		_depth = 1;
	}
	return self;
}

-(NSURLRequest *)request
{
    NSMutableURLRequest *req=[self newRequestWithPath:self.path method:@"PROPFIND"];
//    NSLog(@"request url=%@",req.URL);
    if (_depth>1) {
        [req setValue:@"infinity" forHTTPHeaderField:@"Depth"];
    }else{
        [req setValue:[NSString stringWithFormat:@"%d",_depth] forHTTPHeaderField:@"Depth"];
    }
    
    [req setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
//	[req setValue:nil forHTTPHeaderField:@"Content-Length"];
    [req setValue:@"close" forHTTPHeaderField:@"Connection"];
	[req setHTTPBody:[self generateBody]];
	
	return req;
}

-(id)resultForData:(NSData *)data
{
//    NSString *string=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"string:%@",string);
    LEOWebDAVParser *parser=[[LEOWebDAVParser alloc] initWithData:data];
    NSError *error = nil;
	NSArray *items = [parser parse:&error];
	if (error) {
        #ifdef DEBUG
        NSLog(@"XML Parse error: %@", error);
        #endif
	}
    // 不显示隐藏文件
    NSMutableArray *result=[NSMutableArray array];
    for (LEOWebDAVItem *item in items) {
        if (![item.displayName hasPrefix:@"."]) {
            [item setRootURL:self.rootURL];
//            NSLog(@"path:%@,   rel:%@",self.path,item.relativeHref);
//            NSLog(@"type:%@",item.contentType);
            if (![item.relativeHref isEqualToString:self.relativePath]) {
                [result addObject:item];
            }
        }
    }
	return result;
}

#pragma mark - Private method
-(NSData *)generateBody{
    NSMutableString* o = [NSMutableString string];
	[o appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"];
	[o appendString:@"<D:propfind xmlns:D=\"DAV:\">\n"];
//    [o appendString:@"<D:propfind>\n"];
	[o appendString:@"	<D:prop>"];
	[o appendString:@"		<D:resourcetype/>\n"];
	
	if((kWebDAVProperty & LEOWebDAVPropertyCreationDate) == LEOWebDAVPropertyCreationDate) {
		[o appendString:@"		<D:creationdate/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertyLastModifiedDate) == LEOWebDAVPropertyLastModifiedDate) {
		[o appendString:@"		<D:getlastmodified/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertyDisplayName) == LEOWebDAVPropertyDisplayName) {
		[o appendString:@"		<D:displayname/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertyContentLength) == LEOWebDAVPropertyContentLength) {
		[o appendString:@"		<D:getcontentlength/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertyContentType) == LEOWebDAVPropertyContentType) {
		[o appendString:@"		<D:getcontenttype/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertyLockDiscovery) == LEOWebDAVPropertyLockDiscovery) {
		[o appendString:@"		<D:lockdiscovery/>\n"];
	}
	
	if((kWebDAVProperty & LEOWebDAVPropertySupportedLock) == LEOWebDAVPropertySupportedLock) {
		[o appendString:@"		<D:supportedlock/>\n"];
	}
	
	[o appendString:@"	</D:prop>"];
	[o appendString:@"</D:propfind>"];
	
	return [o dataUsingEncoding:NSUTF8StringEncoding];
}
@end
