//
//  LEOWebDAVParser.h
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LEOWebDAVParser : NSObject<NSXMLParserDelegate>
-(id)initWithData:(NSData *)data;
-(NSArray *)parse:(NSError **)error;
@end
