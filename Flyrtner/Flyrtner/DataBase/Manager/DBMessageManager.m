//
//  DBMessageManager.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "DBMessageManager.h"

@implementation DBMessageManager

@synthesize context;

-(id)init{
    if (self = [super init]){
        AppDelegate *appdelegate = [[UIApplication sharedApplication]delegate];
        context = [appdelegate managedObjectContext];
    }
    return self;
}

-(BOOL)saveMessage:(NSDictionary *)message inChat:(NSString *)chatId{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:TABLE_NAME inManagedObjectContext:context];
    NSManagedObject *newMessage = [[NSManagedObject alloc]initWithEntity:entitydesc insertIntoManagedObjectContext:context];
    
    [newMessage setValue:(id)[message objectForKey:@"message"] forKey:@"message"];
    [newMessage setValue:(id)[message objectForKey:@"messageId"] forKey:@"messageId"];
    [newMessage setValue:(id)[message objectForKey:@"send"] forKey:@"send"];
    [newMessage setValue:(id)[message objectForKey:@"size"] forKey:@"size"];
    [newMessage setValue:(id)[message objectForKey:@"type"] forKey:@"type"];
    [newMessage setValue:(id)[message objectForKey:@"userFrom"] forKey:@"userFrom"];
    [newMessage setValue:(id)[message objectForKey:@"chatId"] forKey:@"chatId"];
    [newMessage setValue:(id)[message objectForKey:@"mine"] forKey:@"mine"];
    //[newMessage setValue:[NSDate date] forKey:@"lastMessageDate"];
    
    NSError *error;
    [context save:&error];
    
    NSLog(@"Message saved");
    return TRUE;
}

-(NSArray *)getMessages:(NSString *)chatId{
    NSEntityDescription *entitydesc = [NSEntityDescription entityForName:TABLE_NAME inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    [request setEntity:entitydesc];
    
    // NSNumber *minimumSalary = ...;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(chatId like %@)", chatId];
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
            NSString *message = [obj valueForKey:@"message"];
            NSString *send = [obj valueForKey:@"send"];
            NSString *userFrom =[obj valueForKey:@"userFrom"];
        }
        return matchingData;
    }
}

@end
