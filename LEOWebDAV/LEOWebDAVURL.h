//
//  LEOWebDAVURL.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEOWebDAVURL : NSObject
@property (readonly) NSString *host;
@property (readonly) NSString *href;
@property (readonly) NSURL *url;
-(id)initWithURL:(NSURL*)url;
-(id)initWithHost:(NSString *)_host andHref:(NSString *)_href;
@end
