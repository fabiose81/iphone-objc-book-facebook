//
//  BookViewController.m
//  book
//
//  Created by Fabio Estrela on 28/11/16.
//  Copyright © 2016 Fabio Estrela. All rights reserved.
//

#import "BookViewController.h"



@interface BookViewController ()

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookArray = [[NSMutableArray alloc] init];
    
    self.conexaoUtil = [[ConexaoUtil alloc] init];
    
    self.uiUtils = [[UIUtils alloc] init];
    self.requestWS = [[RequestWS alloc] init];
    
    
    if([self.conexaoUtil statusInternet]){
         [self.requestWS getBooks :@"resultGetBooks"];
    }else{
        [self.uiUtils showAlertMessage:@"Connection" : @"No internet connection!"];
    }
   
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(resultGetBooks:)
                                                 name:@"resultGetBooks"
                                               object:nil];
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-50, [[UIScreen mainScreen] bounds].size.width, 50)];
    loginButton.delegate = self;
    [self.view addSubview:loginButton];
    
}

- (void) loginButton:	(FBSDKLoginButton *)loginButton didCompleteWithResult:	(FBSDKLoginManagerLoginResult *)result error:	(NSError *)error{}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)addBook:(id)sender{
   [self.bookArray addObject:[self.uiTextFieldTitle text]];
    [self.uiTableViewBook reloadData];
}

- (IBAction) cancelDeleteBook:(UIButton *)sender{
    [self.uiButtonTrash setHidden:NO];
    [self.uiButtonCheck setHidden:YES];
    [self.uiButtonCancel setHidden:YES];
    
    [self.uiTableViewBook setEditing:NO animated:YES];
}

- (IBAction) confirmDeleteBook:(UIButton *)sender{
    [self.uiButtonTrash setHidden:NO];
    [self.uiButtonCheck setHidden:YES];
    [self.uiButtonCancel setHidden:YES];
    
    [self.uiTableViewBook setEditing:NO animated:YES];
    

    NSMutableArray *bookToDelete = [NSMutableArray array];
    for(Book *book in self.bookArray){
        if([book checked] == YES)
            [bookToDelete addObject:book];
    }
    
    [self.bookArray removeObjectsInArray:bookToDelete];

        
   [self.uiTableViewBook reloadData];
}

- (IBAction)removeBook:(UIButton *)sender{
    [self.uiButtonTrash setHidden:YES];
    [self.uiButtonCheck setHidden:NO];
    [self.uiButtonCancel setHidden:NO];
    
    [self.uiTableViewBook setEditing:YES animated:YES];
}

-(void)resultGetBooks:(NSNotification *) notification{
    
    NSArray *arrayBooks = [notification object];
    
    __block NSOperationQueue *myQueue = [[NSOperationQueue alloc] init];
        [myQueue addOperationWithBlock: ^ {
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^ {
                for (int i=0; i<[arrayBooks count]; i++) {
                    Book *book = [[Book alloc] init];
                    [book setIdBook:[[arrayBooks objectAtIndex:i] objectForKey:@"id"]];
                    [book setTitle:[[arrayBooks objectAtIndex:i] objectForKey:@"title"]];
                    [self.bookArray addObject:book];
                }
                  [self.uiTableViewBook reloadData];
            }];
        }];
 }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *simpleTableIdentifier = @"BookCustomCell";
    BookCustomCell *bookCustomCell = (BookCustomCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    
    if (bookCustomCell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BookCustomCell" owner:self options:nil];
        bookCustomCell = [nib objectAtIndex:0];
    }
    
   [bookCustomCell setTintColor: [UIColor whiteColor]];
    
    UIView *bgColorView = [[UIView alloc] init];
    [bgColorView setBackgroundColor:UIColorFromRGB(0x5AD7B1)];
   [bookCustomCell setSelectedBackgroundView:bgColorView];

    bookCustomCell.titleLabel.text = [[self.bookArray objectAtIndex:indexPath.row] title];

    return bookCustomCell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      [[self.bookArray objectAtIndex:indexPath.row] setChecked:YES];
 }

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
       [[self.bookArray objectAtIndex:indexPath.row] setChecked:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.bookArray count];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
