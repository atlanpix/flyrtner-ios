//
//  DBMessageManager.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 17/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
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
