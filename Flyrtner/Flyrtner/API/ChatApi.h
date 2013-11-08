//
//  ChatApi.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

/** Chat API: 81.45.19.228:8000/api */

#import <Foundation/Foundation.h>
#import "BaseApi.h"

@interface ChatApi : BaseApi {}

#pragma mark -
#pragma mark roomCreate

/** POST: /chat/room/create */
- (void) roomCreate:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

/** POST: /chat/room/create */
- (void) roomCreate:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;

@end
