//
//  Message.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject

@property (nonatomic, retain, readonly) NSString *message;
@property (nonatomic, readonly)  BOOL fromMe;
@property (nonatomic, readonly)  NSString *author;
@property (nonatomic, readonly)  NSString *image;

- (id)initWithMessage:(NSString *)message fromMe:(BOOL)fromMe author:(NSString *)author image:(NSData *)image;

@end
