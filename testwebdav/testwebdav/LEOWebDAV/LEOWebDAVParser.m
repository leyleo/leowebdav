//
//  LEOWebDAVParser.m
//  LEOWebDAV
//
//  Created by Liu Ley on 12-10-31.
//  Copyright (c) 2012年 SAE. All rights reserved.
//

#import "LEOWebDAVParser.h"
#import "LEOWebDAVItem.h"

@interface LEOWebDAVParser ()
{
    NSXMLParser *_parser;
    NSMutableArray *_items;
    NSMutableString *_currentString;
    BOOL _inResponseType;
    LEOWebDAVItem *_currentItem;
}
@end

@implementation LEOWebDAVParser
-(id)initWithData:(NSData *)data
{
    NSParameterAssert(data != nil);
	
	self = [super init];
	if (self) {
		_items = [[NSMutableArray alloc] init];
		
		_parser = [[NSXMLParser alloc] initWithData:data];
		[_parser setDelegate:self];
		[_parser setShouldProcessNamespaces:YES];
	}
	return self;
}


-(NSArray *)parse:(NSError **)error
{
    if (![_parser parse]) {
		if (error) {
			*error = [_parser parserError];
		}
		return nil;
	}
	return [_items copy];
}

#pragma mark - Private method
-(NSString *)revertDateISO:(NSString *)dateString
{
    static NSDateFormatter *dataFormatterISO;
    if (dataFormatterISO == nil) {
        dataFormatterISO = [[NSDateFormatter alloc] init];
        dataFormatterISO.timeZone=[NSTimeZone timeZoneForSecondsFromGMT:8];
    }

    [dataFormatterISO setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    return [self stringForDate:[dataFormatterISO dateFromString:dateString]];
}

-(NSString *)revertDateRFC:(NSString *)dateString
{
    static NSDateFormatter *dataFormatterRFC;
    if (dataFormatterRFC == nil) {
        dataFormatterRFC = [[NSDateFormatter alloc] init];
        [dataFormatterRFC setDateFormat:@"EEE',' dd MMM yyyy HH':'mm':'ss z"];
        [dataFormatterRFC setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT"]];
        dataFormatterRFC.locale=[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    }
        // Fri, 26 Oct 2012 14:40:17 GMT
    NSDate *date=[dataFormatterRFC dateFromString:dateString];
    NSString *string=[self stringForDate:date];
//    NSLog(@"date:%@, %@",dateString,string);
    return string;
}

-(NSString *)stringForDate:(NSDate *)date
{
    static NSDateFormatter *outer;
    if (outer == nil) {
        outer=[[NSDateFormatter alloc] init];
    }
    [outer setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [outer stringFromDate:date];
}

#pragma mark - Delegate
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[_currentString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
	attributes:(NSDictionary *)attributeDict {
	
	_currentString = [[NSMutableString alloc] init];
	
	if ([elementName isEqualToString:@"response"]) {
		_currentItem = [[LEOWebDAVItem alloc] init];
	}
	else if ([elementName isEqualToString:@"resourcetype"]) {
		_inResponseType = YES;
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if ([elementName isEqualToString:@"href"]) {
		_currentItem.href = [_currentString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	}
	else if ([elementName isEqualToString:@"getcontentlength"]) {
		_currentItem.contentLength = [_currentString longLongValue];
	}
	else if ([elementName isEqualToString:@"getcontenttype"]) {
		_currentItem.contentType = _currentString;
	}
	else if ([elementName isEqualToString:@"modificationdate"]) {
		_currentItem.modifiedDate = [self revertDateISO:_currentString];
	}
	else if ([elementName isEqualToString:@"getlastmodified"]) {
		_currentItem.modifiedDate = [self revertDateRFC:_currentString];
//        NSLog(@"modify:%@",_currentString);
	}
	else if ([elementName isEqualToString:@"creationdate"]) {
		_currentItem.creationDate = [self revertDateISO:_currentString];
//        NSLog(@"create:%@",_currentString);
	}
	else if ([elementName isEqualToString:@"resourcetype"]) {
		_inResponseType = NO;
	}
	else if ([elementName isEqualToString:@"collection"] && _inResponseType) {
		_currentItem.type = LEOWebDAVItemTypeCollection;
	}
	else if ([elementName isEqualToString:@"response"]) {
		[_items addObject:_currentItem];
		
		_currentItem = nil;
	}
	
	_currentString = nil;
}
@end
