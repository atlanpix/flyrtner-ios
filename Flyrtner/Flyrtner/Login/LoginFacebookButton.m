//
//  LoginFaceButton.m
//  Vuqio
//
//  Created by Juan Covas Medina on 25/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import "LoginFacebookButton.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FlyrtnerApi.h"

@interface LoginFacebookButton (){
	NSString *username;
	SEL logout, login;
	id vc;
	
}
@end

@implementation LoginFacebookButton

@synthesize fbLogin;

+(void)setLoginFacebookButton: (FBLoginView *)fbLogin InView:(UIView *) view in:(CGRect)rect withDefaultImage:(NSString *)defaultIm andHighlightedImage:(NSString *)highlighted withLabel: (UILabel*) label{
	
	fbLogin.frame = rect;
	fbLogin.readPermissions = @[@"email", @"user_likes"];
	fbLogin.publishPermissions = @[@"publish_actions"];
	fbLogin.defaultAudience = FBSessionDefaultAudienceFriends;
	
	
	for (id obj in fbLogin.subviews)
	{
		if ([obj isKindOfClass:[UIButton class]])
		{
			UIButton * loginButton =  obj;
			loginButton.frame = CGRectMake(0, 0, rect.size.width, rect.size.height);
			[loginButton setImage:[UIImage imageNamed:defaultIm] forState:UIControlStateNormal];
			[loginButton setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
		}
        
        if ([obj isKindOfClass:[UILabel class]])
        {
            if (label){
                
                UILabel * loginLabel = obj;
                loginLabel=label;
            }
            else {
                ((UILabel *)obj).hidden = YES;
            }
        }
	}
	[view addSubview:fbLogin];
}



@end
