//
//  LoginView.m
//  Flyrtner
//
//  Created by Enrique Mendoza Robaina on 09/11/13.
//  Copyright (c) 2013 Cabeza la Vaca. All rights reserved.
//

#import "LoginView.h"

@interface LoginView (){
    AppDelegate *appDelegate;
    FlyrtnerApi *flyrtnerAPI;
    NSDictionary<FBGraphUser> *userInfo;
}

@end

@implementation LoginView

@synthesize infoSegue, fbLoginView;

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
    
    AppCore *appCore = [[AppCore alloc] init];
    appCore getUserId
    
    fbLoginView = [[FBLoginView alloc] init];
    
    [LoginFacebookButton setLoginFacebookButton: fbLoginView InView:self.view
                                         in:CGRectMake(52, 300, 217, 40)
                           withDefaultImage:@"loginFacebook.png"
                        andHighlightedImage:@"loginFacebook-pushed.png"
                                  withLabel:nil];
    fbLoginView.delegate=self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metodos para el login de facebook
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
	if (![[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_FACEBOOK]){
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
			 if (!error) {
				 
				 // Guardamos el nombre de usuario
				 flyrtnerAPI = [[FlyrtnerApi alloc]init];
				 
				 if ([[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_FACEBOOK_BACKEND]){
					 // TODO: IR A LA OTRA VENTANA
                     [self performSegueWithIdentifier:@"toLogin" sender:self];
				 }
				 else{
					 NSDictionary *json = [NSDictionary dictionaryWithObjectsAndKeys:
										   [user valueForKey:@"id"], @"idFacebook",
										   [user valueForKey:@"email"], @"email",
										   [user valueForKey:@"username"], @"usernameFB",
										   [[FBSession.activeSession accessTokenData] accessToken], @"oauthTokenFB",
										   [NSString stringWithFormat:@"http://graph.facebook/%@/picture",[user valueForKey:@"id"]], @"urlImage",
										   [user valueForKey:@"name"], @"name",
										   [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"], @"regId",
										   @"iphone", @"systemPhone", nil];
					 [flyrtnerAPI loginFacebook:json calledBy:self withSuccess:@selector(returnLoginFacebook:)];
				 }

				 NSData *imageData =
				 [NSData dataWithContentsOfURL: [NSURL URLWithString:[NSString stringWithFormat:@"http://graph.facebook.com/%@/picture",[user valueForKey:@"username"]]]];
				 [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:FACEBOOK_IMAGE];
				 [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:PROFILE_IMAGE];
				 [[NSUserDefaults standardUserDefaults] setObject:user forKey:FACEBOOK_PROFILE];
				 [[NSUserDefaults standardUserDefaults] setObject:[user valueForKey:@"name"] forKey:PROFILE_NAME];
				 
				 //fbLoginView.hidden=YES;
				 [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_FACEBOOK];
				 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 userInfo = user;
				 
			 }
		 }];
//		if ([[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_FACEBOOK] &&
//			[[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_TWITTER]){
//			[self.navigationController popViewControllerAnimated:YES];
//		}
	}
}

-(void)returnLoginFacebook:(NSDictionary *) response{
	
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:LOGGED_FACEBOOK_BACKEND];
    NSString *userId = [response objectForKey:@"user_id"];
	[[NSUserDefaults standardUserDefaults] setObject:userId forKey:USER_ID];
	[[NSUserDefaults standardUserDefaults] synchronize];
    
    [LoginFacebookButton setLoginFacebookButton: fbLoginView InView:self.view
                                             in:CGRectMake(52, 300, 217, 40)
                               withDefaultImage:@"loginFacebook-logout.png"
                            andHighlightedImage:@"loginFacebook-logout-pushed.png"
                                      withLabel:nil];
    
    [self performSegueWithIdentifier:@"toFlights" sender:self];
}

@end
