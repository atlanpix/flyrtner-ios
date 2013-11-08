//
//  DBChat.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DBChat : NSManagedObject

@property (nonatomic, retain) NSString * chatId;
@property (nonatomic, retain) NSString * creatorId;
@property (nonatomic, retain) NSString * lastMessage;
@property (nonatomic, retain) NSString * lastMessageDate;
@property (nonatomic, retain) NSString * members;
@property (nonatomic, retain) NSString * photo;
@property (nonatomic, retain) NSString * title;

@end
