//
//  ViewController.m
//  book
//
//  Created by Fabio Estrela on 26/11/16.
//  Copyright © 2016 Fabio Estrela. All rights reserved.
//

#import "ViewController.h"
#import "BookViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([FBSDKAccessToken currentAccessToken]!= nil)
    {
        [self goToBookViewController];
    }
    else
    {
        FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-50, [[UIScreen mainScreen] bounds].size.width, 50)];
        loginButton.delegate = self;
        [self.view addSubview:loginButton];
    }

}

- (void) loginButton:	(FBSDKLoginButton *)loginButton didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result error:	(NSError *)error{
    [self goToBookViewController];
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{}

- (void) goToBookViewController{
    BookViewController *bookViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"BookViewController"];
    [self.navigationController pushViewController:bookViewController animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
