//
//  PeopleView.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
#import "FlyrtnerApi.h"
#import "Flight.h"
#import "PeopleCell.h"

@interface PeopleView : UIViewController<UITableViewDataSource,UITableViewDelegate,NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *infoSegue;

@end
