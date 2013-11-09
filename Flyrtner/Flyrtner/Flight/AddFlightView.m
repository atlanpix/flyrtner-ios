//
//  AddFlightView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "AddFlightView.h"

@interface AddFlightView (){
    FlyrtnerApi *flyrtnerAPI;
    NSDictionary *responseApi;
}

@end

@implementation AddFlightView

@synthesize flightNumberLabel;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [flightNumberLabel resignFirstResponder];
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
    
    [flightNumberLabel setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier]isEqualToString:@"toFlights"]){
        
        if (![flightNumberLabel.text  isEqual: @""]){
            NSDictionary *info = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  flightNumberLabel.text,@"FLIGHT_NUMBER",
                                  nil];
            
            FlightView *flightViewController = segue.destinationViewController;
            [flightViewController setInfoSegue:info];
        }
    }
}

@end
