//
//  LEOWebDAVItem.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVItem.h"
#import "LEOWebDAVUtility.h"
#import "LEOContentTypeConvert.h"

@interface LEOWebDAVItem ()
{
    LEOWebDAVItemType type;
    NSString *href;
    NSString *displayName;
    NSString *creationDate;
    NSString *modifiedDate;
    
    long long contentLength;
    
    NSURL *_rootURL;
    NSString *_relativeHref;
    NSString *_location;
    NSString *_contentSize;
    NSString *_cacheName;
    NSString *_contentType;
}
@end

@implementation LEOWebDAVItem
@synthesize type;
@synthesize href;
@synthesize creationDate,modifiedDate;
@synthesize contentLength;

- (id)init {
	self = [super init];
	if (self) {
		type = LEOWebDAVItemTypeFile;
	}
	return self;
}

-(id)initWithItem:(LEOWebDAVItem *)item{
    self = [self init];
	if (self) {
		type=item.type;
        href=[item.href copy];
        creationDate=[item.creationDate copy];
        modifiedDate=[item.modifiedDate copy];
        _contentType=[item.contentType copy];
        contentLength=item.contentLength;
        [self setRootURL:item.rootURL];
	}
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"href = %@; modificationDate = %@; contentLength = %lld; "
            @"contentType = %@; creationDate = %@; resourceType = %d; displayName=%@",
            href, modifiedDate, contentLength, _contentType,
            creationDate, type, self.displayName];
}

-(NSString*)displayName {
	if(displayName == nil || displayName.length == 0) {
		return [[href lastPathComponent] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	} else {
		return displayName;
	}
}

-(void)setRootURL:(NSURL*)_rootUrl
{
    _rootURL=[_rootUrl copy];
    NSString *root=[_rootURL absoluteString];
    NSString *relativeRoot=[_rootURL relativePath];
    NSString *temp=[NSString stringWithString:href];
    if ([href hasPrefix:relativeRoot]) {
        temp=[temp substringFromIndex:relativeRoot.length ];
    }
    if([root rangeOfString:@"%"].length == 0) {
        temp = [temp stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    _relativeHref=[[NSString alloc] initWithFormat:@"%@",temp];
}

-(NSString *)contentSize
{
    if (_contentSize == nil) {
            _contentSize=[[NSString alloc] initWithFormat:@"%@",[LEOWebDAVUtility formattedFileSize:contentLength]];
    }
    return _contentSize;
}

-(NSURL *)rootURL
{
    return _rootURL;
}

-(NSString *)url
{
    return [[_rootURL absoluteString] stringByAppendingString:_relativeHref];
}

-(NSString *)cacheName
{
    if (_cacheName ==nil) {
        NSString *name=[NSString stringWithFormat:@"%@_%@",self.url,self.creationDate];
        _cacheName = [[NSString alloc] initWithFormat:@"%@",[[LEOWebDAVUtility getInstance] md5ForData:[name dataUsingEncoding:NSUTF8StringEncoding]]];
    }
    return _cacheName;
}

-(NSString *)contentType
{
    if (_contentType==nil) {
        if (self.type==LEOWebDAVItemTypeCollection) {
            //
            _contentType=@"httpd/unix-directory";
        } else {
            NSString *_extend=[[self displayName] pathExtension];
            NSString *result=[[LEOExtensionToMIME getInstance] searchMimeFromExtension:_extend];
            _contentType=result==nil?@"default":result;
        }
    }
    return _contentType;
}

-(void)setContentType:(NSString *)contentType
{
    _contentType=nil;
    if (contentType==nil) {
        return;
    }
    if ([LEOWebDAVUtility isEmptyString:contentType]) {
        return;
    }
    _contentType=[contentType copy];
}

-(void)setLocation:(NSString *)location
{
    _location=[[NSString alloc] initWithString:location];
//    NSLog(@"href:%@;relative:%@;location:%@",href,_relativeHref,_location);
}

-(NSString *)relativeHref{
    return _relativeHref;
}
@end
