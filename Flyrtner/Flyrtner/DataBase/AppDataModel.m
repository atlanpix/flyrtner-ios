//
//  AppDataModel.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 15/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "AppDataModel.h"

@implementation AppDataModel

// Global attributes
@synthesize appAdInfo, appChatInfo, appFlightInfo, appMessageInfo, appUserInfo;

static AppDataModel *instance =nil;
+(AppDataModel *)getInstance
{
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance = [AppDataModel new];
        }
    }
    return instance;
}
@end