//
//  LEOWebDAVDeleteRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-6.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVRequest.h"
#import "LEOWebDAVItem.h"

@interface LEOWebDAVDeleteRequest : LEOWebDAVRequest
@property(strong) LEOWebDAVItem *info;
@end
