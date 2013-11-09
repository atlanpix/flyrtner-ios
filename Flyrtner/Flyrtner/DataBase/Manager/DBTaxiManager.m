//
//  DBTaxiManager.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "DBTaxiManager.h"

@implementation DBTaxiManager

@synthesize context;

-(id)init{
    if (self = [super init]){
        AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
        context = [appdelegate managedObjectContext];
    }
    return self;
}

-(BOOL)saveTaxi:(NSDictionary *)taxiInfo{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:TABLE_NAME inManagedObjectContext:context];
    NSManagedObject *newTaxi = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newTaxi setValue:(id)[taxiInfo objectForKey:@"flightId"] forKey:@"flightId"];
    [newTaxi setValue:(id)[taxiInfo objectForKey:@"flightNumber"] forKey:@"flightNumber"];
    [newTaxi setValue:(id)[taxiInfo objectForKey:@"origin"] forKey:@"origin"];
    [newTaxi setValue:(id)[taxiInfo objectForKey:@"destination"] forKey:@"destination"];
    
    NSError *error;
    [context save:&error];
    
    NSLog(@"Taxi saved");
    return TRUE;
}

-(NSArray *)getTaxis{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:TABLE_NAME inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    // NSNumber *minimumSalary = ...;
    NSPredicate *predicate = nil;
    [request setPredicate:predicate];
    
    NSError *error;
    NSArray *matchingData = [context executeFetchRequest:request error:&error];
    
    // If the user is not logged in previously
    if (matchingData.count <=0 ){
        //self.displaylabel.text = @"No person find";
        return FALSE;
    } else {
        // If the user is already logged in
        for (NSManagedObject *obj in matchingData) {
            NSString *flightNumber = [obj valueForKey:@"flightNumber"];
            NSString *origin = [obj valueForKey:@"origin"];
            NSString *destination =[obj valueForKey:@"destination"];
        }
        return matchingData;
    }
}

@end
