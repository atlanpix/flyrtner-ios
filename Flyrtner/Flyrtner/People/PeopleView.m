//
//  PeopleView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "PeopleView.h"

@interface PeopleView (){
    FlyrtnerApi *flyrtnerAPI;
    NSMutableArray *people;
    Flight *flight;
}

@end

@implementation PeopleView

@synthesize tableView, infoSegue;

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
    
    // Init flights
    people = [[NSMutableArray alloc] init];
    
    [tableView setDataSource:self];
	[tableView setDelegate:self];
    
    /*[flyrtnerAPI getFlights:@"0"
     calledBy:self
     withSuccess:@selector(getFlightsDidEnd:)];*/
    
//    Person *personExample1 = [[Person alloc]init];
//    personExample1.name= @"Enrique Mendoza";
//    personExample1.image = @"http://";
//    personExample1.relationship = @"friend";
//    personExample1.userId = @"5171717171717";
    
//    @property NSString *image;
//    @property NSString *name;
//    @property NSString *userId;
//    @property NSString *relationship;
//    @property NSMutableArray *likes;
//    @property NSMutableArray *checkins;
//    @property NSMutableArray *books;
//    @property NSMutableArray *musics;
//    @property NSMutableArray *televisions;
//    @property NSMutableArray *interests;
    
//    [people addObject:personExample1];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    Flight *flight = delegate.flight;
    
    flyrtnerAPI = [[FlyrtnerApi alloc] init];
    if (flight) {
        [flyrtnerAPI getUsersFlight:flight.flightId
                           calledBy:self
                        withSuccess:@selector(getUsersFlightDidEnd:)];
    }
}

-(void)viewDidAppear:(BOOL)animated{
        [flyrtnerAPI getUsersFlight:flight.flightId
                           calledBy:self
                        withSuccess:@selector(getUsersFlightDidEnd:)];
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
    return [people count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	//Tabla de la guia
    PeopleCell *cell = (PeopleCell *)[tableView dequeueReusableCellWithIdentifier:@"person" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[PeopleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"person"];
    }
    
    Person *person = [people objectAtIndex:indexPath.row];
    
//    {"id":"527df5cae4b0dd559e0840fa","urlImage":"http://graph.facebook.com/690958614/picture?type=small","username":"Ra�l Marcos Lorenzo","usernameFB":"Ra�l Marcos Lorenzo"}]
    cell.name.text = person.name;
    NSURL *imageURL = [NSURL URLWithString:person.image];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    UIImage *image = [UIImage imageWithData:imageData];
    [cell.image setImage:image];
    
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

-(void)getUsersFlightDidEnd:(NSArray *)response{
    NSLog(@"getUsersFlightDidEnd");
    
    for (NSDictionary *obj in response){
        Person *person = [[Person alloc] init];
        person.name = [obj objectForKey:@"username"];
        person.image = [obj objectForKey:@"urlImage"];
        
        if (people == nil){
            people = [[NSMutableArray alloc] init];
        }
        [people addObject:person];
    }
    
    [self.tableView reloadData];
    
}

- (void) defaultFailureCallback
{
    NSLog(@"Failure");
}
@end
