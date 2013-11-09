//
//  FlyrtnerApi.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "FlyrtnerApi.h"

/* Warning suppress: "Perform selector can cause a memo leak"
 * Stack overflow question number 7017281
 */
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation FlyrtnerApi {}

#pragma mark -
#pragma mark Flight
- (void) flight:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;
{
    [self flight:data
        calledBy:calledBy
      withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];
}

- (void) flight:(NSDictionary *)data
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/getFly"
                  withData:data
               withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                   
                   if (! json) {
                       [calledBy performSelector:failureCallback];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:json];
                   }
               }];
}

#pragma mark -
#pragma mark Facebook

- (void) loginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
{
    [self loginFacebook:data
                   calledBy:calledBy
                withSuccess:successCallback
                 andFailure:@selector(defaultFailureCallback)];
}

- (void) loginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
                andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/loginFacebook"
                  withData:data
               withHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error) {

                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                   
                   if (! json) {
                       [calledBy performSelector:failureCallback];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:json];
                   }
               }];
}

#pragma mark Taxi
// POST
- (void) createTaxi:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback{

    [self createTaxi:data
        calledBy:calledBy
     withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];
}

- (void) createTaxi:(NSDictionary *)data
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback{
    
    [self placePostRequest:@"api/createTaxi"
                  withData:data
               withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
                   
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawData options:0 error:nil];
                   
                   if (! json) {
                       [calledBy performSelector:failureCallback];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:json];
                   }
               }];

}

// PUT
- (void) checkTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback{
    
    [self checkTaxi:taxiId
             userId:userId
        calledBy:calledBy
     withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];

}

- (void) checkTaxi:(NSString *)taxiId
            userId:(NSString *)userId
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
        andFailure:(SEL)failureCallback{
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/checkTaxi?taxiId=%@&userId=%@",taxiId,userId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"checkTaxi OK");
                      [calledBy performSelector:successCallback];
                  }
              }];

}


- (void) uncheckTaxi:(NSString *)taxiId
              userId:(NSString *)userId
            isOnline:(BOOL)isOnline
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback{
    
    [self uncheckTaxi:taxiId
               userId:userId
        calledBy:calledBy
     withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];

}

// PUT
- (void) uncheckTaxi:(NSString *)taxiId
              userId:(NSString *)userId
            calledBy:(id)calledBy
         withSuccess:(SEL)successCallback
          andFailure:(SEL)failureCallback{
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/uncheckTaxi?taxiId=%@&userId=%@",taxiId,userId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"uncheckTaxi OK");
                      [calledBy performSelector:successCallback];
                  }
              }];

}

// GET
- (void) getTaxis:(NSString *)flightId
        calledBy:(id)calledBy
     withSuccess:(SEL)successCallback{
    
    [self getTaxis:flightId
             calledBy:calledBy
          withSuccess:successCallback
           andFailure:@selector(defaultFailureCallback)];
}

- (void) getTaxis:(NSString *)flightId
        calledBy:(id)calledBy
     withSuccess:(SEL)successCallback
      andFailure:(SEL)failureCallback{
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/getTaxis?flyId=%@",flightId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"getTaxis OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];

}
#pragma mark -
#pragma mark People

- (void) getUsersFlight:(NSString *)flightId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback{
    
    [self getUsersFlight:flightId
          calledBy:calledBy
       withSuccess:successCallback
        andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersFlight:(NSString *)flightId
         calledBy:(id)calledBy
      withSuccess:(SEL)successCallback
       andFailure:(SEL)failureCallback{
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/getIdsUsersFly?fly_id=%@",flightId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"getUsersFlight OK");
                      [calledBy performSelector:successCallback withObject:array];
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
