//
//  ViewController.h
//  book
//
//  Created by Fabio Estrela on 26/11/16.
//  Copyright © 2016 Fabio Estrela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface ViewController : UIViewController <FBSDKLoginButtonDelegate>

- (void) loginButton: (FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:	(NSError *)error;
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;
- (void) goToBookViewController;
@end

