//
//  DBChatManager.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 15/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "AppDataModel.h"

@interface DBChatManager : NSObject {}

@property (weak) NSManagedObjectContext *managedObjectContext;

-(id)init;

-(BOOL)chatExists:(NSString *)chatId;

-(BOOL)saveChat:(NSDictionary *)chatInfo;

@end
