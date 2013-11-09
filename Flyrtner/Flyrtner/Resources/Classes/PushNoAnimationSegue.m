//
//  PushNoAnimationSegue.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 08/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "PushNoAnimationSegue.h"

@implementation PushNoAnimationSegue

-(void) perform{
	[[[self sourceViewController] navigationController] pushViewController:[self destinationViewController] animated:NO];
	//[self.sourceViewController popViewControllerAnimated:NO];

}

@end
