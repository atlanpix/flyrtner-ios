//
//  VuqioApi.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 16/09/13.
//  Copyright (c) 2013 Atlanpix SL. All rights reserved.
//

/** Vuiqio API: 81.45.19.228:8000/api */
 
#import <Foundation/Foundation.h>
#import "BaseApi.h"

@interface VuqioApi : BaseApi {}

#pragma mark -
#pragma mark EPG
/** GET: /JSON/dd-mm-YY/F.json */
- (void) getEPG:(NSDateComponents *)date
         atTime:(NSString *)time
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback;

/** GET: /JSON/dd-mm-YY/F.json */
- (void) getEPG:(NSDateComponents *)date
           atTime:(NSString *)time
       calledBy:(id)calledBy
    withSuccess:(SEL)successCallback
     andFailure:(SEL)failureCallback;
#pragma mark -
#pragma mark Twitter

/** POST: /api/loginTwitter */
- (void) postLoginTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback;

/** POST: /api/loginTwitter */
- (void) postLoginTwitter:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback;

/** POST: /api/joinTwitter */
- (void) postJoinTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

/** POST: /api/joinTwitter */
- (void) postJoinTwitter:(NSDictionary *)data
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Facebook

/** POST: /api/loginFacebook */
- (void) postLoginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback;

/** POST: /api/loginFacebook */
- (void) postLoginFacebook:(NSDictionary *)data
                  calledBy:(id)calledBy
               withSuccess:(SEL)successCallback
                andFailure:(SEL)failureCallback;

/** POST: /api/joinFacebook */
- (void) postJoinFacebook:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback;

/** POST: /api/joinFacebook */
- (void) postJoinFacebook:(NSDictionary *)data
                 calledBy:(id)calledBy
              withSuccess:(SEL)successCallback
               andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark PutOnline

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)idVuqio
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback;

/** PUT: /api/online (idUser:String,online:Boolean) */
- (void) putOnline:(NSString *)idVuqio
          isOnline:(BOOL)isOnline
          calledBy:(id)calledBy
       withSuccess:(SEL)successCallback
        andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark LastMessages

/** GET: /api/lastMessages(idUser:String) */
- (void) getLastMessages:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

/** GET: /api/lastMessages(idUser:String) */
- (void) getLastMessages:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark UsersProgram

/** GET: /api/getUsersProgram(programId:String) */
- (void) getUsersProgram:(NSString *)idProgram
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

/** GET: /api/getUsersProgram(programId:String) */
- (void) getUsersProgram:(NSString *)idProgram
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark FriendsVuqio

/** GET: /api/getFriendsVuqio(idUser:String) */
- (void) getFriendsVuqio:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback;

/** GET: /api/getFriendsVuqio(idUser:String) */
- (void) getFriendsVuqio:(NSString *)idVuqio
                calledBy:(id)calledBy
             withSuccess:(SEL)successCallback
              andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark AllUser

/** GET: /api/getAllUser(numPag:Integer)*/
- (void) getAllUser:(NSString *)pageNumber
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback;

/** GET: /api/getAllUser(numPag:Integer)*/
- (void) getAllUser:(NSString *)pageNumber
           calledBy:(id)calledBy
        withSuccess:(SEL)successCallback
         andFailure:(SEL)failureCallback;

-(void) getGuideForHour:(NSDate *) date
			calledBy:(id)calledBy
		 withSuccess:(SEL)successCallback;

-(void) getGuideForHour:(NSDate *) date
			calledBy:(id)calledBy
		 withSuccess:(SEL)successCallback
		  andFailure:(SEL)failureCallback;


#pragma mark -
#pragma mark CurrentProgram

/* postCurrentProgram: send a notification of a visit to a program
 *
 * Data format (JSON):
 * {
 *   "programId":"asdasdsd-asdasd-asdasd-asdasd-asdasd-asdasd",
 *   "userId":"id del usuario"
 * }
 */
- (void) postCurrentProgram:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback;

- (void) postCurrentProgram:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback
                 andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark ProgramCheckIn

/** POST: api/programcheckin
 *
 * postProgramCheckIn: a vuqio user is
 *
 * Data format (JSON):
 * {
 *   "programId":"asdasdsd-asdasd-asdasd-asdasd-asdasd-asdasd",
 *   "userId":"id del usuario"
 * }
 */
- (void) postProgramCheckIn:(NSDictionary *)data
                   calledBy:(id)calledBy withSuccess:(SEL)successCallback;

/** POST: api/programcheckin */
- (void) postProgramCheckIn:(NSDictionary *)data
                   calledBy:(id)calledBy
                withSuccess:(SEL)successCallback
                 andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark getUsersProgramFriend
/** GET: /api/getUsersProgramFriend(programId:String,userId:String)*/
- (void) getUsersProgramFriend:(NSString *)programId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback;

/** GET: /api/getUsersProgramFriend(numPag:Integer)*/
- (void) getUsersProgramFriend:(NSString *)programId
                        userId:(NSString *)userId
                          view:(id)view
                      calledBy:(id)calledBy
                   withSuccess:(SEL)successCallback
                    andFailure:(SEL)failureCallback;

#pragma mark -
#pragma mark Failure Callbacks

- (void) defaultFailureCallback;

@end
