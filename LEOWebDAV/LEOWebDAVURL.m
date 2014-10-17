//
//  LEOWebDAVURL.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVURL.h"
@interface LEOWebDAVURL ()
{
    NSURL *_url;
}
@end
@implementation LEOWebDAVURL
-(id)initWithURL:(NSURL*)url
{
    self=[super init];
    if(self){
        _url=[[NSURL alloc] initWithString:[url absoluteString]];
    }
    return self;
}
-(id)initWithHost:(NSString *)_host andHref:(NSString *)_href
{
    self=[super init];
    if(self){
        if([_href hasPrefix:[NSString stringWithFormat:@"/%@", [_host lastPathComponent]]]) {
			_href = [_href substringFromIndex:[_host lastPathComponent].length+1];
		}
		if([_href rangeOfString:@"%"].length == 0) {
			_href = [_href stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
		}

        _url=[[NSURL alloc] initWithString:[_host stringByAppendingString:_href]];
    }
    return self;
}

-(NSString *)host
{
    return [NSString stringWithFormat:@"%@://%@", [_url scheme], [_url host]];
}

-(NSString *)href
{
    return [[_url absoluteString] substringFromIndex:self.host.length];
}

-(NSURL *)url
{
    return _url;
}
@end
