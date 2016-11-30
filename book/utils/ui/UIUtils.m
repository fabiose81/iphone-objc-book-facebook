//
//  UIUtils.m
//  Sebraetec
//
//  Created by Fabio Estrela on 14/08/15.
//  Copyright (c) 2015 Sebrae. All rights reserved.
//

#import "UIUtils.h"

@implementation UIUtils

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void) showAlertMessage : (NSString *) title : (NSString *) message
{
    
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    
}


@end
