//
//  LEOWebDAVDownloadRequest.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVRequest.h"
@class LEOWebDAVItem;
@class KTPhotoView;
@interface LEOWebDAVDownloadRequest : LEOWebDAVRequest
@property(nonatomic,retain) LEOWebDAVItem *item;
@property(nonatomic,retain) NSDictionary *dictionary;
@property(nonatomic,assign) KTPhotoView *view;
@property(nonatomic) SEL callback;
@end
