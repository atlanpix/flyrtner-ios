//
//  TaxiView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "TaxiView.h"

@interface TaxiView (){
    FlyrtnerApi *flyrtnerAPI;
    NSMutableArray *taxis;
    DBTaxiManager *dbTaxiManager;
    Flight *flight;
    NSString *userId;
}

@end

@implementation TaxiView

@synthesize address, number, tableView;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
    //return [number resignFirstResponder];
}

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
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    flight = delegate.flight;
    AppCore *appCore = [[AppCore alloc] init];
    userId = [appCore getUserId];
    flyrtnerAPI = [[FlyrtnerApi alloc] init];
    
    [flyrtnerAPI getTaxis:flight.flightId calledBy:self withSuccess:@selector(getTaxisDidEnd:)];
    [address setDelegate:self];
    [number setDelegate:self];
    
    [tableView setDataSource:self];
	[tableView setDelegate:self];
    
    taxis = [[NSMutableArray alloc] init];
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
    
    return [taxis count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	//Tabla de la guia
    TaxiCell *cell = (TaxiCell *)[tableView dequeueReusableCellWithIdentifier:@"taxi" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[TaxiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"taxi"];
    }
    
    Taxi *taxi = [taxis objectAtIndex:indexPath.row];
    
    cell.address.text = taxi.address;
    cell.people.text = taxi.numberPeople;
    
    return cell;
}
// Fin de funciones para rellenar la tabla

#pragma mark -

- (IBAction)addTaxi:(id)sender {
    NSDictionary *infoTaxi = [NSDictionary dictionaryWithObjectsAndKeys:
                              flight.flightId,@"fly_id",
                              address.text,@"address",
                              number.text,@"numberSit",
                              userId,@"userCreate", nil];
    
    
    [flyrtnerAPI createTaxi:infoTaxi calledBy:self withSuccess:@selector(createTaxiDidEnd:)];
    [number resignFirstResponder];
    [address resignFirstResponder];
}

-(void)createTaxiDidEnd:(id)response{
    NSLog(@"createTaxiDidEnd");
    
    Taxi *taxi = [[Taxi alloc] init];
    taxi.address = address.text;
    taxi.numberPeople = number.text;
    taxi.flightNumber = flight.flightNumber;
    taxi.creatorId = userId;
    taxi.taxiId = [response objectForKey:@"id"];
    
    address.text = @"";
    number.text = @"1";
    
    [taxis addObject:taxi];
    
    [self.tableView reloadData];
}

-(void)getTaxisDidEnd:(id)response{
    NSLog(@"getTaxisDidEnd");
    for (NSDictionary *obj in response){
        Taxi *taxi = [[Taxi alloc] init];
        taxi.address = [obj objectForKey:@"address"];
        taxi.numberPeople = [obj objectForKey:@"numberSit"];
        
        if (taxis == nil){
            taxis = [[NSMutableArray alloc] init];
        }
        [taxis addObject:taxi];
    }
    
    [self.tableView reloadData];
}

- (void) defaultFailureCallback
{
    NSLog(@"Failure");
}
@end













