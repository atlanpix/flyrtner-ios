//
//  AppDataModel.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 15/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBChat.h"
#import "DBMessage.h"
#import "DBUser.h"
#import "DBFlight.h"
#import "DBAd.h"

@interface AppDataModel : NSObject {
    // Global attributes
    /*DBChat *appChatInfo;
    DBChannel *appChannelInfo;
    DBGuide *appGuideInfo;
    DBMessage *appMessageInfo;
    DBProgram *appProgramInfo;
    DBUser *appUserInfo;*/
}

@property(nonatomic,retain) DBChat *appChatInfo;
@property(nonatomic,retain) DBFlight *appFlightInfo;
@property(nonatomic,retain) DBAd *appAdInfo;
@property(nonatomic,retain) DBMessage *appMessageInfo;
@property(nonatomic,retain) DBUser *appUserInfo;

+(AppDataModel*)getInstance;

@end
