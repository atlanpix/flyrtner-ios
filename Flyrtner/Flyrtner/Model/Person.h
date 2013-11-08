//
//  Person.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property NSString *image;
@property NSString *name;
@property NSString *userId;
@property NSString *relationship;
@property NSMutableArray *likes;
@property NSMutableArray *checkins;
@property NSMutableArray *books;
@property NSMutableArray *musics;
@property NSMutableArray *televisions;
@property NSMutableArray *interests;

@end
