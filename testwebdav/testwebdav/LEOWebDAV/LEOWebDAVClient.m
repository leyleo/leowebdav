//
//  LEOWebDAVClient.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-30.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVClient.h"
#import "LEOWebDAVBaseRequest.h"
#import "LEOWebDAVDefines.h"
#import "LEOWebDAVRequest.h"

@interface LEOWebDAVClient ()
{
    NSURL *_rootURL;
    NSString *_userName;
    NSString *_password;
    NSOperationQueue *_queue;
    BOOL _allowUntrusedCertificate;
}
@end

@implementation LEOWebDAVClient
@synthesize rootURL=_rootURL;
@synthesize userName=_userName;
@synthesize password=_password;
@synthesize allowUntrusedCertificate=_allowUntrusedCertificate;
@dynamic requestCount,maxRequestsCount;
#pragma mark - Public methods
-(id) initWithRootURL:(NSURL *)url andUserName:(NSString *)name andPassword:(NSString*)password
{
    NSParameterAssert(url!=nil);
    NSParameterAssert(name!=nil);
    
    self=[super init];
    if(self){
        _rootURL=[url copy];
        _userName=[name copy];
        _password=[password copy];
        _allowUntrusedCertificate=NO;
        
        _queue=[[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:kWebDAVDefaultMaxRequestCount];
        [_queue addObserver:self
                 forKeyPath:@"operationCount"
                    options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
                    context:NULL];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        _allowUntrusedCertificate=NO;
        
        _queue=[[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:kWebDAVDefaultMaxRequestCount];
        [_queue addObserver:self
                 forKeyPath:@"operationCount"
                    options:(NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew)
                    context:NULL];
    }
    return self;
}

-(void)setupRootURL:(NSURL *)url
        andUserName:(NSString *)name
        andPassword:(NSString*)password
{
    NSParameterAssert(url!=nil);
    NSParameterAssert(name!=nil);
    
    _rootURL = nil;
    _rootURL=[url copy];
    
    _userName = nil;
    _userName=[name copy];
    
    _password = nil;
    _password=[password copy];
}

-(void)enqueueRequest:(LEOWebDAVBaseRequest*)enRequest
{
    NSParameterAssert(enRequest!=nil);
    NSParameterAssert(_rootURL!=nil);
    NSParameterAssert(_userName!=nil);
    enRequest.userName=_userName;
    enRequest.password=_password;
    enRequest.rootURL=_rootURL;
    enRequest.allowUntrusedCertificate=_allowUntrusedCertificate;

    [_queue addOperation:enRequest];
}

-(NSArray *)currentArray
{
    if (!_queue) {
        return nil;
    }
    return [_queue operations];
}

-(void)cancelDelegate
{
    if (!_queue) {
        return;
    }
    for (LEOWebDAVRequest *req in [_queue operations]) {
        req.delegate=nil;
    }
}

-(void)cancelRequest
{
    NSLog(@"current queue:%d",[self requestCount]);
    if (!_queue) {
        return;
    }
    [_queue cancelAllOperations];
}

-(void)dealloc
{
    if (_queue) {
        [_queue removeObserver:self forKeyPath:@"operationCount"];
    }
}
#pragma mark - Property methods

-(NSUInteger)requestCount
{
    if (!_queue) {
        return 0;
    }
    return [_queue operationCount];
}

- (NSInteger)maxRequestsCount
{
    if (!_queue) {
        return 0;
    }
	return [_queue maxConcurrentOperationCount];
}

- (void)setmaxRequestsCount:(NSInteger)aVal {
    if (_queue) {
        [_queue setMaxConcurrentOperationCount:aVal];
    }
}

#pragma mark -  Protocol methods
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"operationCount"]) {
		[self willChangeValueForKey:@"requestCount"];
		[self didChangeValueForKey:@"requestCount"];
	}
}
@end
