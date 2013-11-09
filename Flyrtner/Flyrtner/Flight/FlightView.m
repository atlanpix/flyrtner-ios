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
    DBFlightManager *dbFlightManager;
}

@end

@implementation FlightView

@synthesize flightTable, infoSegue;

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
    
    // Ocultamos el botón de ir atrás
    self.navigationItem.hidesBackButton = YES;
    
    // Put delegates to flight table
    [flightTable setDataSource:self];
	[flightTable setDelegate:self];
    
    // Init flights
    
    /*[flyrtnerAPI getFlights:@"0"
                   calledBy:self
                withSuccess:@selector(getFlightsDidEnd:)];*/
    
//    Flight *flightExample1 = [[Flight alloc]init];
//    flightExample1.flightNumber = @"VY1234";
//    flightExample1.origin = @"CLV";
//    flightExample1.destination = @"BCN";
//    
//    Flight *flightExample2 = [[Flight alloc]init];
//    flightExample2.flightNumber = @"VY7101";
//    flightExample2.origin = @"TFE";
//    flightExample2.destination = @"LPA";
//    
//    Flight *flightExample3 = [[Flight alloc]init];
//    flightExample3.flightNumber = @"VY1961";
//    flightExample3.origin = @"LND";
//    flightExample3.destination = @"LPA";
//    
//    [flights addObject:flightExample1];
//    [flights addObject:flightExample2];
//    [flights addObject:flightExample3];
    
    [self getFlightsFromDataBase];
    
    if ([infoSegue objectForKey:@"FLIGHT_NUMBER"]){
        NSString *flightNumber = (NSString *)[infoSegue objectForKey:@"FLIGHT_NUMBER"];
        flyrtnerAPI = [[FlyrtnerApi alloc] init];
        AppCore *appCore = [[AppCore alloc] init];
        NSString *userId = [appCore getUserId];
        NSDictionary *info = [NSDictionary dictionaryWithObjectsAndKeys:
                              flightNumber,@"flyNumber",
                              userId,@"user_id", nil];
        [flyrtnerAPI flight:info
                      calledBy:self
                   withSuccess:@selector(flightDidEnd:)];
    }
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
		
        UITabBarController *tabar = segue.destinationViewController;
        // Enviamos a la pestaña Info
        ChatView *programViewcontrollertabar = [tabar.viewControllers objectAtIndex:0];
        [programViewcontrollertabar setInfoSegue:info];
        // Enviamos al tabBar
        [[segue destinationViewController] setInfoSegue:info];
    }
}

#pragma mark -
#pragma mark CallBacks
-(void)defaultCallback{
    NSLog(@"defaultCallback");
}

-(void)flightDidEnd:(NSDictionary *)result{
    NSLog(@"flightDidEnd");
    Flight *flight = [[Flight alloc] init];
    flight.flightId = [result objectForKey:@"id"];
    flight.origin = [result objectForKey:@"origin"];
    flight.destination = [result objectForKey:@"destination"];
    flight.flightNumber = [result objectForKey:@"flyNumber"];
    
    if (flights == nil){
        flights = [[NSMutableArray alloc] init];
    }
    [flights addObject:flight];
    
    [self.flightTable reloadData];
    
    NSDictionary *flightInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                   flight.flightId, @"flightId",
                   flight.flightNumber, @"flightNumber",
                   flight.origin, @"origin",
                   flight.destination, @"destination",
                   nil];
    
    if (flightInfo){
        [dbFlightManager saveFlight:flightInfo];
    }
}

-(void)getFlightsFromDataBase{
    dbFlightManager = [[DBFlightManager alloc] init];
    NSArray *response;
    response = [dbFlightManager getFlights];
    
    // Mostramos los mensajes
    // Inicializamos la variables _messages
    flights = [[NSMutableArray alloc] init];
    
    // Recorremos el vector messages que nos ha devuelto la base de datos local
    for (NSManagedObject *obj in response) {
        // Creamos un mensaje con el formato que podemos guardar en _messages (Message.h)
        Flight *newFlight = [[Flight alloc] init];
        newFlight.flightId = [obj valueForKey:@"flightId"];
        newFlight.flightNumber = [obj valueForKey:@"flightNumber"];
        newFlight.origin = [obj valueForKey:@"origin"];
        newFlight.destination = [obj valueForKey:@"destination"];
        
        // Lo añadimos al vector
        [flights addObject:newFlight];
    }
        
    [self.flightTable reloadData];
}

#pragma mark -
@end
