//
//  DBChatManager.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 15/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "DBChatManager.h"

@implementation DBChatManager{
    NSManagedObjectContext *context;
}

@synthesize managedObjectContext;

-(id)init{
    if (self = [super init]){
        AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
        context = [appdelegate managedObjectContext];
    }
    return self;
}

-(BOOL)chatExists:(NSString *)chatId{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"DBChat" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];

   // NSNumber *minimumSalary = ...;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"(chatId like %@)", chatId];
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
            //AppDataModel *appDataModel=[AppDataModel getInstance];
            //appDataModel.appChatInfo = [[DBChat alloc] init];
            /*appDataModel.appChatInfo.chatId = [obj valueForKey:@"chatId"];
            appDataModel.appChatInfo.creatorId = [obj valueForKey:@"creatorId"];
            appDataModel.appChatInfo.members =[obj valueForKey:@"members"];*/
            NSString *chatId = [obj valueForKey:@"chatId"];
            NSString *creatorId = [obj valueForKey:@"creatorId"];
            NSString *members =[obj valueForKey:@"members"];
        }
        return TRUE;
    }
}

-(BOOL)saveChat:(NSDictionary *)chatInfo{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:@"DBChat" inManagedObjectContext:context];
    NSManagedObject *newChat = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newChat setValue:(NSString *)[chatInfo objectForKey:@"chatId"] forKey:@"chatId"];
    [newChat setValue:(NSString *)[chatInfo objectForKey:@"creatorId"] forKey:@"creatorId"];
    [newChat setValue:(NSString *)[chatInfo objectForKey:@"members"] forKey:@"members"];
    
    
    NSError *error;
    [context save:&error];
    
    NSLog(@"Chat saved");
    return TRUE;
}

@end
