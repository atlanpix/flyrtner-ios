//
//  Message.h
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 12/08/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, retain, readonly) NSString *message;
@property (nonatomic, readonly)  BOOL fromMe;
@property (nonatomic, readonly)  NSString *author;
@property (nonatomic, readonly)  NSString *image;

- (id)initWithMessage:(NSString *)message fromMe:(BOOL)fromMe author:(NSString *)author image:(NSData *)image;

@end
