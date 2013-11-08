//
//  VuqioApi.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 16/09/13.
//  Copyright (c) 2013 Atlanpix SL. All rights reserved.
//

#import "VuqioApi.h"

/* Warning suppress: "Perform selector can cause a memo leak"
 * Stack overflow question number 7017281
 */
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@implementation VuqioApi {}



#pragma mark -
#pragma mark EPG
- (void) getEPG:(NSDateComponents *)date
           atTime:(NSString *)time
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;
{
    [self getEPG:date
          atTime:time
        calledBy:calledBy
      withSuccess:successCallback
      andFailure:@selector(defaultFailureCallback)];
}

- (void) getEPG:(NSDateComponents *)date
         atTime:(NSString *)time
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback
{
    NSArray *timeToArray = [time componentsSeparatedByString:@":"];
    int hours = [[timeToArray objectAtIndex:0] integerValue];
    int minutes = [[timeToArray objectAtIndex:1] integerValue];
    int jsonNumberToRequest = hours*2 + minutes/30;
    NSString *dayCorrection = @"";
    if (date.day < 10)
    {
        dayCorrection = @"0";
    }
    NSString *dayToRequest = [NSString stringWithFormat:@"%d-%d-%d",
                              date.day,
                              date.month,
                              date.year];
    //NSLog(@"%@/%@%@/%d.json",URL_EPG_JSON,dayCorrection,dayToRequest,jsonNumberToRequest);
    NSString *url = [NSString stringWithFormat:@"%@/%@%@/%d.json",URL_EPG_JSON,dayCorrection,dayToRequest,jsonNumberToRequest];
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
#pragma mark Twitter

- (void) postLoginTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
{
    [self postLoginTwitter:data
                  calledBy:calledBy
               withSuccess:successCallback
                andFailure:@selector(defaultFailureCallback)];
}

- (void) postLoginTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/loginTwitter"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   NSString *string = [[NSString alloc] initWithData:rawData
                                                            encoding:NSUTF8StringEncoding];
                   
                   if ([string isEqual:@"Missing some parameter"]) {
                       [calledBy performSelector:failureCallback];
                   } else {
                       NSLog(@"OK");
                       [calledBy performSelector:successCallback withObject:string];
                   }
               }];
}

- (void) postJoinTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self postJoinTwitter:data
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) postJoinTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/joinTwitter"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *rawData, NSError *error) {
                   // TODO
               }];
}

#pragma mark -
#pragma mark Facebook

- (void) postLoginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
{
    [self postLoginFacebook:data
                   calledBy:calledBy
                withSuccess:successCallback
                 andFailure:@selector(defaultFailureCallback)];
}

- (void) postLoginFacebook:(NSDictionary *)data
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

- (void) postJoinFacebook:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
{
    [self postJoinFacebook:data
                  calledBy:calledBy
               withSuccess:successCallback
                andFailure:@selector(defaultFailureCallback)];
}

- (void) postJoinFacebook:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback
{
    [self placePostRequest:@"api/joinFacebook"
                  withData:data
               withHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                   // TODO
               }];
}

#pragma mark -
#pragma mark PutOnline

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)idVuqio
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
{
    [self putOnline:idVuqio
           isOnline:isOnline
           calledBy:calledBy
        withSuccess:successCallback
         andFailure:@selector(defaultFailureCallback)];
}

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)idVuqio
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

- (void) getLastMessages:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getLastMessages:idVuqio
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getLastMessages:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/lastMessages?idUser=%@",idVuqio]
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
                      NSLog(@"VuqioAPI: getLastMessages OK");
                      [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

#pragma mark -
#pragma mark Useres Program

- (void) getUsersProgram:(NSString *)idProgram
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getUsersProgram:idProgram
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersProgram:(NSString *)idProgram
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getUsersProgram?programId=%@",idProgram]
              withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
        
                  // NSString *string = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
                  NSArray *array = [NSJSONSerialization JSONObjectWithData:rawData
                                                                   options:0
                                                                     error:nil];
        
                  if ([array count] == 0) {
                    [calledBy performSelector:failureCallback];
                  } else {
                    NSLog(@"VuqioAPI: getUsersProgram OK");
                    [calledBy performSelector:successCallback withObject:array];
                  }
              }];
}

#pragma mark -
#pragma mark FriendsVuqio

- (void) getFriendsVuqio:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getFriendsVuqio:[NSString stringWithFormat:@"api/getFriendsVuqio?idUser=%@", idVuqio]
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getFriendsVuqio:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getFriendsVuqio?idUser=%@", idVuqio]
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
                    NSLog(@"VuqioAPI: getFriendsVuqio OK");
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
#pragma mark GetGuide

- (void) getGuideForHour:(NSDate *) date
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
{
    [self getGuideForHour:date
                 calledBy:calledBy
              withSuccess:successCallback
               andFailure:@selector(defaultFailureCallback)];
}

- (void) getGuideForHour:(NSDate *) date
				calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback
{
    
	NSString *url = [NSString stringWithFormat:@"http://www.coding.es/vuqio/services_test.php"];
    
    NSURL *urlUsers = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlUsers];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
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
                       NSLog(@"VuqioApi: postCurrentProgram OK");
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
#pragma mark getUsersProgramFriend
- (void) getUsersProgramFriend:(NSString *)programId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
{
    [self getUsersProgramFriend:programId
                         userId:userId
                           view:view
                       calledBy:calledBy
                    withSuccess:successCallback
                     andFailure:@selector(defaultFailureCallback)];
}

- (void) getUsersProgramFriend:(NSString *)programId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback
{
    [self placeGetRequest:[NSString stringWithFormat:@"api/getUsersProgramFriend?programId=%@&userId=%@",programId,userId]
              withHandler:^(NSURLResponse *urlResponse, NSData *rawData, NSError *error) {
                  
                  // NSString *string = [[NSString alloc] initWithData:rawData encoding:NSUTF8StringEncoding];
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
                                            programId, @"program", nil];
                      NSLog(@"VuqioAPI: getUsersProgramFriend OK");
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
