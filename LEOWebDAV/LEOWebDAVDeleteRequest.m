//
//  LEOWebDAVDeleteRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-6.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVDeleteRequest.h"


@interface LEOWebDAVDeleteRequest ()
{
    LEOWebDAVItem *_info;
}
@end
@implementation LEOWebDAVDeleteRequest
@synthesize info=_info;
- (NSURLRequest *)request
{
	return [self newRequestWithPath:self.path method:@"DELETE"];
}

-(id)resultForData:(NSData *)data
{
    return data;
}
@end
