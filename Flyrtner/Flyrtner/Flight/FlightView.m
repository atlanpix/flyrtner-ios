//
//  FlightView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "FlightView.h"

@interface FlightView (){
    FlyrtnerApi *flyrtnerAPI;
    NSMutableArray *flights;
}

@end

@implementation FlightView

@synthesize flightTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // Put delegates to flight table
    [flightTable setDataSource:self];
	[flightTable setDelegate:self];
    
    // Init flights
    flights = [[NSMutableArray alloc] init];
    
    /*[flyrtnerAPI getFlights:@"0"
                   calledBy:self
                withSuccess:@selector(getFlightsDidEnd:)];*/
    
    Flight *flightExample1 = [[Flight alloc]init];
    flightExample1.flightNumber = @"VY1190";
    flightExample1.origin = @"LGW";
    flightExample1.destination = @"BCN";
    
    Flight *flightExample2 = [[Flight alloc]init];
    flightExample2.flightNumber = @"VY7101";
    flightExample2.origin = @"TFE";
    flightExample2.destination = @"LPA";
    
    Flight *flightExample3 = [[Flight alloc]init];
    flightExample3.flightNumber = @"VY1961";
    flightExample3.origin = @"LND";
    flightExample3.destination = @"LPA";
    
    [flights addObject:flightExample1];
    [flights addObject:flightExample2];
    [flights addObject:flightExample3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table methods

// Funciones obligatorias para als tablas
// define el número de secciones de la tabla
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [flights count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	//Tabla de la guia
    FlightCell *cell = (FlightCell *)[flightTable dequeueReusableCellWithIdentifier:@"flight" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[FlightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"flight"];
    }
    
    Flight *flight = [flights objectAtIndex:indexPath.row];
    
    cell.origin.text = flight.origin;
    cell.destination.text = flight.destination;
    cell.flightNumber.text = flight.flightNumber;
    
//    [cell.channelImage setImageWithURL:[NSURL URLWithString:c.imageURL]
//                      placeholderImage:[UIImage imageNamed:[c.imageURL
//                                                            stringByReplacingOccurrencesOfString:@"http://estrelladamm.vuqio.com/static/channels/p/" withString:@""]]
//                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
//                                 //... completion code here ...
//                             }];
//    NSString *userId = [appCore getUserId];
//    if (userId){
//        [flyrtnerAPI getUsersFlight:flight.flightNumber
//                             userId:userId
//                               view:cell
//                           calledBy:self
//                        withSuccess:@selector(getUsersFlight:view:)];
//    }
    
    return cell;
}


// Fin de funciones para rellenar la tabla

#pragma mark -
#pragma mark Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

	if([[segue identifier]isEqualToString:@"toFlight"]){
        
		NSIndexPath *indexPath = [self.flightTable indexPathForSelectedRow];
        
        NSDictionary *info = [[NSDictionary alloc]initWithObjectsAndKeys:
                                 [flights objectAtIndex:indexPath.row],@"FLIGHT",
                                 nil];
		
        ChatView *chatViewController = [[ChatView alloc] init];
        UITabBarController *tbc = [segue destinationViewController];
        chatViewController = (ChatView *)[[tbc customizableViewControllers] objectAtIndex:0];
    }
}

#pragma mark -
#pragma mark CallBacks
-(void)defaultCallback{
    NSLog(@"defaultCallback");
}

-(void)getFlightsDidEnd:(NSArray *)result{
    NSLog(@"getFlightsDidEnd");
    for (NSDictionary *item in result) {
        Flight *flight = [[Flight alloc] init];
    }
}
#pragma mark -
@end
