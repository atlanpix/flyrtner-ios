//
//  ChatApi.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 12/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "ChatApi.h"

/* Warning suppress: "Perform selector can cause a memo leak"
 * Stack overflow question number 7017281
 */
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation ChatApi {}

#pragma mark -
#pragma mark CreateRoom

- (void) roomCreate:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
{
    [self roomCreate:data calledBy:calledBy
         withSuccess:successCallback
          andFailure:@selector(defaultFailureCallback)];
}

- (void) roomCreate:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback {
    [self placePostRequest:@"room/create"
                  withData:data
               withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
        
        NSString *string = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
        
        if (! string)
        {
            [calledBy performSelector:failureCallback];
        } else {
            NSLog(@"OK");
            [calledBy performSelector:successCallback withObject:string];
        }
    }];
}

#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback
{
    NSLog(@"Failure");
}

@end
