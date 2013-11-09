//
//  VuqioApi.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

/** Vuiqio API: 81.45.19.228:8000/api */
 
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
//
//#pragma mark PutOnline
///** PUT: /api/online (idUser:String,online:Boolean) */
//- (void) putOnline:(NSString *)userId
//          isOnline:(BOOL)isOnline
//          calledBy:(id)calledBy
//       withSuccess:(SEL)successCallback;
//
///** PUT: /api/online (idUser:String,online:Boolean) */
//- (void) putOnline:(NSString *)userId
//          isOnline:(BOOL)isOnline
//          calledBy:(id)calledBy
//       withSuccess:(SEL)successCallback
//        andFailure:(SEL)failureCallback;
//
//#pragma mark -
//
//#pragma mark LastMessages
//
///** GET: /api/lastMessages(idUser:String) */
//- (void) getLastMessages:(NSString *)userId
//                calledBy:(id)calledBy
//             withSuccess:(SEL)successCallback;
//
///** GET: /api/lastMessages(idUser:String) */
//- (void) getLastMessages:(NSString *)userId
//                calledBy:(id)calledBy
//             withSuccess:(SEL)successCallback
//              andFailure:(SEL)failureCallback;
//
//#pragma mark -
//#pragma mark UsersFlight
//
///** GET: /api/getUsersFlight(flightId:String) */
//- (void) getUsersFlight:(NSString *)flightId
//                calledBy:(id)calledBy
//             withSuccess:(SEL)successCallback;
//
///** GET: /api/getUsersFlight(flightId:String) */
//- (void) getUsersFlight:(NSString *)flightId
//                calledBy:(id)calledBy
//             withSuccess:(SEL)successCallback
//              andFailure:(SEL)failureCallback;
//
//#pragma mark -
//#pragma mark AllUser
//
///** GET: /api/getAllUser(numPag:Integer)*/
//- (void) getAllUser:(NSString *)pageNumber
//           calledBy:(id)calledBy
//        withSuccess:(SEL)successCallback;
//
///** GET: /api/getAllUser(numPag:Integer)*/
//- (void) getAllUser:(NSString *)pageNumber
//           calledBy:(id)calledBy
//        withSuccess:(SEL)successCallback
//         andFailure:(SEL)failureCallback;
//#pragma mark -
//
//#pragma mark FlightCheckIn
//
//- (void) postFlightCheckIn:(NSDictionary *)data
//                   calledBy:(id)calledBy withSuccess:(SEL)successCallback;
//
//- (void) postFlightCheckIn:(NSDictionary *)data
//                   calledBy:(id)calledBy
//                withSuccess:(SEL)successCallback
//                 andFailure:(SEL)failureCallback;
//
//#pragma mark -
//#pragma mark getUsersFlightFriend
///** GET: /api/getUsersFlightFriend(flightId:String,userId:String)*/
//- (void) getUsersFlightFriend:(NSString *)flightId
//                        userId:(NSString *)userId
//                          view:(id)view
//                      calledBy:(id)calledBy
//                   withSuccess:(SEL)successCallback;
//
///** GET: /api/getUsersFlightFriend(numPag:Integer)*/
//- (void) getUsersFlightFriend:(NSString *)flightId
//                        userId:(NSString *)userId
//                          view:(id)view
//                      calledBy:(id)calledBy
//                   withSuccess:(SEL)successCallback
//                    andFailure:(SEL)failureCallback;
//
//#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;

@end
