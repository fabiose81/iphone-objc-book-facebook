//
//  BookViewController.h
//  book
//
//  Created by Fabio Estrela on 28/11/16.
//  Copyright © 2016 Fabio Estrela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "BookCustomCell.h"
#import "ConexaoUtil.h"
#import "UIUtils.h"
#import "RequestWS.h"

@interface BookViewController : UIViewController <FBSDKLoginButtonDelegate, UITableViewDelegate, UITableViewDataSource>

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@property(nonatomic,strong) IBOutlet UITextField *uiTextFieldTitle;

- (void) loginButton: (FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:	(NSError *)error;
- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton;

- (IBAction)addBook:(id)sender;
- (IBAction)removeBook:(UIButton *)sender;
- (IBAction)confirmDeleteBook:(UIButton *)sender;
- (IBAction)cancelDeleteBook:(UIButton *)sender;

@property(nonatomic,strong) IBOutlet UITableView *uiTableViewBook;
@property(nonatomic,strong) NSMutableArray *bookArray;

@property(nonatomic,strong) IBOutlet UIButton *uiButtonCancel;
@property(nonatomic,strong) IBOutlet UIButton *uiButtonCheck;
@property(nonatomic,strong) IBOutlet UIButton *uiButtonTrash;

@property (nonatomic, strong) ConexaoUtil *conexaoUtil;
@property (nonatomic, strong) UIUtils *uiUtils;
@property (nonatomic, strong) RequestWS *requestWS;

@end
