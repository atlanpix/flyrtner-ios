//
//  AppCore.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 07/11/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "AppCore.h"

@implementation AppCore

- (NSString *) getVuqioId{
    NSObject *idVuqioExists = [[NSUserDefaults standardUserDefaults]objectForKey:VUQIO_ID];
    if (idVuqioExists){
        return (NSString *)idVuqioExists;
    } else {
        return nil;
    }
}

@end
