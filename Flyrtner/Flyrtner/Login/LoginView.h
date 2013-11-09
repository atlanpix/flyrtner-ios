//
//  LoginView.h
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
#import "FlyrtnerApi.h"
#import "LoginFacebookButton.h"

@interface LoginView : UIViewController<UIActionSheetDelegate, FBLoginViewDelegate>

@property (strong, nonatomic) FBLoginView *fbLoginView;

// For segue
@property (strong, nonatomic) NSDictionary *infoSegue;

-(void)returnLoginFacebook:(NSString *) response;

@end
