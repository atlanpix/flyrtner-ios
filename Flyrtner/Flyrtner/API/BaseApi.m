//
//  BaseApi.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "BaseApi.h"

@implementation BaseApi
//
//Inicio de las funciones para recoger el JSON de la web

-(void)placeGetRequest:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock {

    NSString *url = [NSString stringWithFormat:@"%@/%@", URL_API, action];

    
    NSURL *urlUsers = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlUsers];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:ourBlock];
}

-(void)placeGetRequestWithURL:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock {
    NSString *url = [NSString stringWithFormat:@"%@",action];
    
    NSURL *urlUsers = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlUsers];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:ourBlock];
}

-(void)placePostRequest:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@", URL_API, action];
    NSLog(urlString);
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Creamos el JSON desde el data
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataToSend options:0 error:&error];
    
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
        
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:ourBlock];
    }
}

-(void)placePostRequestWithURL:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock {
    NSString *urlString = [NSString stringWithFormat:@"%@", action];
    NSLog(urlString);

    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    // Creamos el JSON desde el data
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataToSend options:0 error:&error];
    
    NSString *jsonString;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
 
        NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
        //[request setHTTPMethod:@"POST"];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
        [request setHTTPBody: requestData];
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:ourBlock];
    }
}

@end
