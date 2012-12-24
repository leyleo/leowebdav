//
//  LEOWebDAVPropertyRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVRequest.h"

typedef enum {
	LEOWebDAVPropertyCreationDate = 1,
	LEOWebDAVPropertyLastModifiedDate = 2,
	LEOWebDAVPropertyDisplayName = 4,
	LEOWebDAVPropertyContentLength = 8,
	LEOWebDAVPropertyContentType = 16,
	LEOWebDAVPropertyCommonProperties = 31,
	LEOWebDAVPropertyETag = 32,
	LEOWebDAVPropertySupportedLock = 64,
	LEOWebDAVPropertyLockDiscovery = 128,
	LEOWebDAVPropertyAllProperties = 4095
} LEOWebDAVProperties;

@interface LEOWebDAVPropertyRequest : LEOWebDAVRequest

@end
