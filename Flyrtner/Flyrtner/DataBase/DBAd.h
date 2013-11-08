//
//  DBAd.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DBAd : NSManagedObject

@property (nonatomic, retain) NSString * members;
@property (nonatomic, retain) NSString * place;
@property (nonatomic, retain) NSString * title;

@end
