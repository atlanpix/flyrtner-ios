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
}

@end

@implementation PeopleView

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
    
    /*[flyrtnerAPI getFlights:@"0"
     calledBy:self
     withSuccess:@selector(getFlightsDidEnd:)];*/
    
    Person *personExample1 = [[Person alloc]init];
    personExample1.name= @"Enrique Mendoza";
    personExample1.image = @"http://";
    personExample1.relationship = @"friend";
    personExample1.userId = @"5171717171717";
    
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
    
    [people addObject:personExample1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
