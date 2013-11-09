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

- (IBAction)addTaxi:(id)sender {
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    flight = delegate.flight;
    AppCore *appCore = [[AppCore alloc] init];
    userId = [appCore getUserId];
    
    NSDictionary *infoTaxi = [NSDictionary dictionaryWithObjectsAndKeys:
                              flight.flightId,@"fly_id",
                              address.text,@"address",
                              number.text,@"numberSit",
                              userId,@"userCreate", nil];
    
    flyrtnerAPI = [[FlyrtnerApi alloc] init];
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
@end













