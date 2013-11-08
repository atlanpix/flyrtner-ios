//
//  Message.m
//  Vuqio
//
//  Created by Enrique Mendoza Robaina on 12/08/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "Message.h"

@implementation Message

@synthesize message = _message;
@synthesize fromMe = _fromMe;
//@synthesize image = _image;

- (id)initWithMessage:(NSString *)message fromMe:(BOOL)fromMe author:(NSString *)author image:(NSData *)image;
{
    self = [super init];
    if (self) {
        _fromMe = fromMe;
        _message = message;
        _author = author;
        _image = image;
    }
    
    return self;
}

@end
