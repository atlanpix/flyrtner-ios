//
//  DateFactory.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFactory : NSObject

// Devuelve la fecha en String en formato UTC del NSDate que se le pase
-(NSString *)getUTCFormateDateString:(NSDate *)localDate;

// Pasamos la fecha que nos viene del JSON a NSDate
-(NSDate *)getNSDateFromJSONDate:(NSString *)date;

// Pasamos la una fecha en String a NSDate con el formato que especificamos
-(NSDate *)getNSDateFromString:(NSString *)date withFormat:(NSString *)forma;

-(NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format;

@end
