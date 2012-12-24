//
//  LEOWebDAVMakeCollectionRequest.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-6.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVMakeCollectionRequest.h"
@interface LEOWebDAVMakeCollectionRequest ()

@end
@implementation LEOWebDAVMakeCollectionRequest
- (NSURLRequest *)request
{
	return [self newRequestWithPath:self.path method:@"MKCOL"];
}

-(id)resultForData:(NSData *)data
{
    return data;
}
@end
