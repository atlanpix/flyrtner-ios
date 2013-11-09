//
//  DBFlightManager.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define TABLE_NAME @"DBFlight"

@interface DBFlightManager : NSObject

@property NSManagedObjectContext *context;

-(id)init;

-(BOOL)saveFlight:(NSDictionary *)flightInfo;

-(NSArray *)getFlights;

@end
