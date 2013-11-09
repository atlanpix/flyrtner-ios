//
//  LoginFaceButton.h
//  Vuqio
//
//  Created by Juan Covas Medina on 25/10/13.
//  Copyright (c) 2013 Buqio SL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>

@interface LoginFacebookButton : NSObject<FBLoginViewDelegate>

@property (strong, nonatomic) FBLoginView *fbLogin;

+(void)setLoginFacebookButton: (FBLoginView *) fbLogin InView:(UIView *) view in:(CGRect) rect withDefaultImage: (NSString *) defaultIm andHighlightedImage: (NSString *) highlighted withLabel:(UILabel *) label ;


@end
