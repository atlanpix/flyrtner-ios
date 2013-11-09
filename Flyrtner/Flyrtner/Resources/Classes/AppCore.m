//
//  AppCore.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
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
