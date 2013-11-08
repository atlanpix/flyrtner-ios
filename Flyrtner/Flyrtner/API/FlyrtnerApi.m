//
//  VuqioApi.m
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
#pragma mark Flights
- (void) getFlights:(NSString *)pageNumber
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;
{
    [self getFlights:pageNumber
        calledBy:calledBy
      withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];
}

- (void) getFlights:(NSString *)pageNumber
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback
{
    NSString *url = [NSString stringWithFormat:@"%@/%@%@/%d.json",URL_API];
    NSLog(url);
    [self placeGetRequestWithURL:url
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  // 1) initialize the array of JSON
                  NSDictionary *guide = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
				  // 2) perform selector
				  if (!guide) {
					  // array = nil if JSONObjectWithData:options:error fails
					  [calledBy performSelector:failureCallback];
				  } else {
					  NSLog(@"VuqioAPI: getGuide OK");
					  [calledBy performSelector:successCallback withObject:guide];
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
               withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {

                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
        
                   /*
                   NSDictionary *json = [NSJSONSerialization JSONObjectWithData:rawData
                                                                        options:0
                                                                          error:nil];
                   */
				   NSLog(@"%@", urlResponse);
                   if (! string) {
                       [calledBy performSelector:failureCallback];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:string];
                   }
               }];
}

#pragma mark -
#pragma mark PutOnline

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)userId
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
{
    [self putOnline:userId
           isOnline:isOnline
           calledBy:calledBy
        withSuccess:successCallback
         andFailure:@selector(defaultFailureCallback)];
}

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)userId
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
        andFailure:(SEL)failureCallback
{
    // TODO
    // [NSString stringWithFormat:@"api/online?idUser=%@?online=%s", idVuqio, isOnline]
}

#pragma mark -
#pragma mark Last messages

- (void) getLastMessages:(NSString *)userId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getLastMessages:userId
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getLastMessages:(NSString *)userId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/lastMessages?idUser=%@",userId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      // array = nil if JSONObjectWithData:options:error fails
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"getLastMessages OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

#pragma mark -
#pragma mark Users Flight

- (void) getUsersFlight:(NSString *)flightId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getUsersFlight:flightId
                calledBy:calledBy
            withSuccess:successCallback
            andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersFlight:(NSString *)flightId
               calledBy:(id)calledBy
            withSuccess:(SEL)successCallback
             andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getUsersProgram?programId=%@",flightId]
              withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                   options:0
                                                                     error:nil];
        
                  if ([array count] == 0) {
                    [calledBy performSelector:failureCallback];
                  } else {
                    NSLog(@"getUsersFlight OK");
                    [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

#pragma mark -
#pragma mark FriendsFlyrtner

- (void) getFriendsFlyrtner:(NSString *)userId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getFriendsFlyrtner:[NSString stringWithFormat:@"api/getFriendsFlyrtner?idUser=%@", userId]
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getFriendsFlyrtner:(NSString *)userId
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getFriendsFlyrtner?idUser=%@", userId]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                // 1) initialize the array of JSON
                NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:0
                                                                   error:nil];
                // 2) perform selector
                if (!array) {
                    // array = nil if JSONObjectWithData:options:error fails
                    [calledBy performSelector:failureCallback];
                } else {
                    NSLog(@"getFriendsFlyrtner OK");
                    [calledBy performSelector:successCallback withObject:array];
                }
              }];
}

#pragma mark -
#pragma mark AllUser

- (void) getAllUser:(NSString *)pageNumber
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
{
    // Note: pageNumber should be integer
    
    [self getAllUser:[NSString stringWithFormat:@"api/getAllUser?numPag=%d", [pageNumber intValue]]
            calledBy:calledBy
         withSuccess:successCallback
          andFailure:@selector(defaultFailureCallback)];
}

- (void) getAllUser:(NSString *)pageNumber
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback
{
    // Note: pageNumber should be integer
    
    [self placeGetRequest:[NSString stringWithFormat:@"api/getAllUser?numPag=%d", [pageNumber intValue]]
              withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                  // 1) initialize the array of JSON
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                                   options:0
                                                                     error:nil];
                  // 2) perform selector
                  if (!array) {
                      // array = nil if JSONObjectWithData:options:error fails
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSLog(@"VuqioAPI: getAllUser OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

#pragma mark -
#pragma mark CurrentProgram

- (void)postCurrentProgram:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
{
    [self postCurrentProgram:data
                    calledBy:calledBy
                 withSuccess:successCallback
                  andFailure:@selector(defaultFailureCallback)];
}

- (void) postCurrentProgram:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback
                 andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/programcurrent"
                  withData:data
               withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {

                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
  
                   if ( ![string isEqual: @"ok"]) {
                       [calledBy performSelector:failureCallback withObject:self];
                   } else {
                       NSLog(@"postCurrentProgram OK");
                       [calledBy performSelector:successCallback];
                   }
               }];
}

#pragma mark -
#pragma mark ProgramCheckIn

- (void) postProgramCheckIn:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback
{
    [self postProgramCheckIn:data
                    calledBy:calledBy
                 withSuccess:successCallback
                  andFailure:@selector(defaultFailureCallback)];
}

- (void) postProgramCheckIn:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback
                 andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/programcheckin"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                   // TODO
               }];
}

#pragma mark -
#pragma mark getUsersFlightFriend
- (void) getUsersFlightFriend:(NSString *)flightId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
{
    [self getUsersFlightFriend:flightId
                         userId:userId
                           view:view
                       calledBy:calledBy
                    withSuccess:successCallback
                     andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersFlightFriend:(NSString *)flightId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getUsersFlightFriend?flightId=%@&userId=%@",flightId,userId]
              withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
                  
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                   options:0
                                                                     error:nil];
                  
                  /*NSDictionary *a = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"5261141c44ae513d6a60c51a", @"id",
                                     @"false", @"online",
                                     @"https://si0.twimg.com/profile_images/1805043997/Picture.jpg", @"urlImage",
                                     @"miguepiscy", @"username",
                                     @"true", @"friend", nil];
                  NSDictionary *b = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"52650d5444ae9cdc08c7b086", @"id",
                                     @"false", @"online",
                                     @"https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash3/c42.42.525.525/s160x160/534850_10201043894131918_1795057456_n.jpg", @"urlImage",
                                     @"enri", @"username",
                                     @"true", @"friend", nil];
                  
                  array = [NSArray arrayWithObjects:a,b,nil];*/
                  
                  if ([array count] == 0) {
                      [calledBy performSelector:failureCallback];
                  } else {
                      NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:
                                            array, @"friends",
                                            flightId, @"flight", nil];
                      NSLog(@"getUsersProgramFriend OK");
                      [calledBy performSelector:successCallback withObject:result withObject:view];
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
