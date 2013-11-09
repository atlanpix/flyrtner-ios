//
//  AppCore.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 07/11/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "AppCore.h"

@implementation AppCore

- (NSString *) getUserId{
    NSObject *userIdExists = [[NSUserDefaults standardUserDefaults]objectForKey:URL_API];
    if (userIdExists){
        return (NSString *)userIdExists;
    } else {
        return nil;
    }
}

@end
