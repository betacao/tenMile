//
//  YHENetworkOperation.m
//  YOHOBoard
//
//  Created by Louis Zhu on 13-2-6.
//  Copyright (c) 2013年 NewPower Co. All rights reserved.
//

#import "YHENetworkOperation.h"
#import "YHENetworkEngine.h"


@implementation YHENetworkOperation


- (id)responseJSON
{
    if (_responseJSON == nil) {
        self.responseJSON = [super responseJSON];
    }

    return _responseJSON;
}


- (BOOL)isStandardYohoCnOperation
{
    NSURLRequest *request = [self readonlyRequest];
    NSString *host = [[request URL] host];
    return [host isEqualToString:kHostName];
}


- (id)responseObject
{
#ifdef IS_TEST
    NSLog(@"%@", [self responseJSON] );
#endif
    return [[self responseJSON] objectForKey:@"data"];
}


- (void)operationSucceeded
{
    [YHENetworkEngine removeOperation:self];
    
    if (![self isStandardYohoCnOperation]) {
        [super operationSucceeded];
        return;
    }
    
    if (![[self.responseJSON allKeys] containsObject:@"status"]) {
        [super operationSucceeded];
        return;
    }
    
    NSInteger responseStatus = [[self.responseJSON objectForKey:@"status"] integerValue];
    if (responseStatus == 0) {
        [super operationSucceeded];
        return;
    }
    
    NSInteger responseCode = [[self.responseJSON objectForKey:@"code"] integerValue];
    if (responseCode != YHEErrorCodeSuccess) {
        NSString *localizedDescription = [self.responseJSON objectForKey:@"message"];
        NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:localizedDescription, NSLocalizedDescriptionKey, nil];
        NSError *error = [NSError errorWithDomain:YHEAPIErrorDomain code:responseCode userInfo:userInfo];
        [super operationFailedWithError:error];
    }
}


- (void)operationFailedWithError:(NSError *)error
{
    [YHENetworkEngine removeOperation:self];
    [super operationFailedWithError:error];
}


@end
