//
//  FlightCell.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *flightNumber;
@property (weak, nonatomic) IBOutlet UILabel *origin;
@property (weak, nonatomic) IBOutlet UILabel *destination;

@end
