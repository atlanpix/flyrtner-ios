//
//  DBMessage.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DBMessage : NSManagedObject

@property (nonatomic, retain) NSString * chatId;
@property (nonatomic, retain) NSString * message;
@property (nonatomic, retain) NSString * messageId;
@property (nonatomic, retain) NSString * mine;
@property (nonatomic, retain) NSString * send;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * userFrom;

@end
