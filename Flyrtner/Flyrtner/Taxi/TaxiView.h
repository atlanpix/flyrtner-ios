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

@interface TaxiView : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *infoSegue;

@end
