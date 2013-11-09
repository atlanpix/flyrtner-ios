//
//  AppDataModel.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 15/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBChat.h"
#import "DBChannel.h"
#import "DBGuide.h"
#import "DBMessage.h"
#import "DBProgram.h"
#import "DBUser.h"

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
@property(nonatomic,retain) DBChannel *appChannelInfo;
@property(nonatomic,retain) DBGuide *appGuideInfo;
@property(nonatomic,retain) DBMessage *appMessageInfo;
@property(nonatomic,retain) DBProgram *appProgramInfo;
@property(nonatomic,retain) DBUser *appUserInfo;

+(AppDataModel*)getInstance;

@end
