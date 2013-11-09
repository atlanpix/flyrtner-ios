//
//  FlyrtnerApi.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

 
#import <Foundation/Foundation.h>
#import "BaseApi.h"

@interface FlyrtnerApi : BaseApi {}

#pragma mark -
#pragma mark Flights

- (void) flight:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;

- (void) flight:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;
#pragma mark -

#pragma mark Facebook
- (void) loginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback;

- (void) loginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
                andFailure:(SEL)failureCallback;

#pragma mark -

#pragma mark Taxi
- (void) createTaxi:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback;

- (void) createTaxi:(NSDictionary *)data
              calledBy:(id)calledBy
           withSuccess:(SEL)successCallback
            andFailure:(SEL)failureCallback;


- (void) checkTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback;

- (void) checkTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
        andFailure:(SEL)failureCallback;


- (void) uncheckTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback;

- (void) uncheckTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
        andFailure:(SEL)failureCallback;


- (void) getTaxis:(NSString *)flightId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

- (void) getTaxis:(NSString *)flightId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;
#pragma mark -

#pragma mark People

- (void) getUsersFlight:(NSString *)flightId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback;

- (void) getUsersFlight:(NSString *)flightId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback;
#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;

@end
