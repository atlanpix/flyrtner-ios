//
//  DBMessageManager.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

#define TABLE_NAME @"DBMessage"

@interface DBMessageManager : NSObject

@property NSManagedObjectContext *context;

-(id)init;

-(BOOL)messageExists:(NSString *)messageId inChat:(NSString *)chatId;

-(int)messageCount:(NSString *)chatId;

-(BOOL)saveMessage:(NSDictionary *)messageInfo inChat:(NSString *)chatId;

-(NSArray *)getMessages:(NSString *)chatId;

@end
