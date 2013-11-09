//
//  DateFactory.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "DateFactory.h"

@implementation DateFactory

// Devuelve la fecha en String en formato UTC del NSDate que se le pase
-(NSString *)getUTCFormateDateString:(NSDate *)localDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:localDate];
    return dateString;
}

// Pasamos la fecha que nos viene del JSON a NSDate
-(NSDate *)getNSDateFromJSONDate:(NSString *)date{
    NSString *_date = [date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _date = [_date stringByReplacingOccurrencesOfString:@".000Z" withString:@""]; // Si usamos el antiguo static, poner solo @"Z"
    
    return [self getNSDateFromString:_date withFormat:@"yyyy-MM-dd HH:mm:ss"];
}

// Pasamos la una fecha en String a NSDate con el formato que especificamos
-(NSDate *)getNSDateFromString:(NSString *)date withFormat:(NSString *)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:format];
    NSDate *returnDate = [dateFormat dateFromString:date];
    
    return returnDate;
}

-(NSString *)dateToString:(NSDate *)date withFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate: date];
}

@end
