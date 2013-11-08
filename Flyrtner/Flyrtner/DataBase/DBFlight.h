//
//  DBFlight.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DBFlight : NSManagedObject

@property (nonatomic, retain) NSString * destination;
@property (nonatomic, retain) NSString * flightNumber;
@property (nonatomic, retain) NSString * origin;

@end
