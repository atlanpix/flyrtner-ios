//
//  FlightView.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlightCell.h"
#import "FlyrtnerApi.h"
#import "Flight.h"
#import "ChatView.h"
#import "DBFlight.h"
#import "DBFlightManager.h"

@interface FlightView : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *flightTable;

@property (strong, nonatomic) NSDictionary *infoSegue;

@end
