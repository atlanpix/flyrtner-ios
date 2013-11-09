//
//  TaxiView.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlyrtnerApi.h"
#import "TaxiCell.h"
#import "DBTaxiManager.h"
#import "Taxi.h"

@interface TaxiView : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *infoSegue;
- (IBAction)addTaxi:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *address;

@end
