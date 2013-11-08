//
//  BaseApi.h
//  Payple
//
//  Created by Pablo López Torres on 15/08/13.
//  Copyright (c) 2013 Atlanpix SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface BaseApi : NSObject

-(void)placeGetRequest:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placeGetRequestWithURL:(NSString *)action withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;

-(void)placePostRequest:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;
-(void)placePostRequestWithURL:(NSString *)action withData:(NSDictionary *)dataToSend withHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))ourBlock;

@end
