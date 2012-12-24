//
//  LEOWebDAVCopyRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-11-12.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVRequest.h"

@interface LEOWebDAVCopyRequest : LEOWebDAVRequest
@property (nonatomic,strong) NSString *destinationPath;
@property (assign) BOOL overwrite;
@end
