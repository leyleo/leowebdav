LEOWebDAV
--

iOS WebDAV client library: LEOWebDAV


How to Use [Demo Code]
--
```Objective-C
NSString *root=@"";
NSString *user=@"";
NSString *password=@"";

LEOWebDAVClient *client=[[LEOWebDAVClient alloc] initWithRootURL:[NSURL URLWithString:root] andUserName:user andPassword:password];

LEOWebDAVPropertyRequest *request=[[LEOWebDAVPropertyRequest alloc] initWithPath:@"/"];
[request setDelegate:self];
[client enqueueRequest:request];

LEOWebDAVDownloadRequest *downRequest=[[LEOWebDAVDownloadRequest alloc] initWithPath:@"/picture1.jpg"];
[downRequest setDelegate:self];
[client enqueueRequest:downRequest];

-(void)request:(LEOWebDAVRequest *)aRequest didFailWithError:(NSError *)error
{
    NSLog(@"error:%@",[error description]);
}

-(void)request:(LEOWebDAVRequest *)aRequest didSucceedWithResult:(id)result
{
    if ([aRequest isKindOfClass:[LEOWebDAVPropertyRequest class]]) {
        NSLog(@"success:%@",result);
    }else if ([aRequest isKindOfClass:[LEOWebDAVDownloadRequest class]]){
        if (result) {
            UIImage *picture=[UIImage imageWithData:result];
            UIImageView *image=[[UIImageView alloc] initWithFrame:self.window.frame];
            image.image=picture;
            [self.window addSubview:image];
        }
    }
}
```
Thanks
--
Reference the following git:

[mattrajca/DAVKit]
https://github.com/mattrajca/DAVKit.git

[ACWebDAV from jkichline/ACConnect]
https://github.com/jkichline/ACConnect.git

Related APP
--
Open Source APP: [TeamDisk_iOS](https://github.com/leyleo/TeamDisk_iOS)
