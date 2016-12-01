//
//  RequestWS.h
//  saudeinfantil
//
//  Created by Fabio Estrela on 21/07/14.
//  Copyright (c) 2014 br.com.firewave. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Book.h"
#import "UIUtils.h"

@interface RequestWS : NSObject

@property(nonatomic,strong) UIUtils *uiUtils;

- (void) getBooks : (NSString *)resultNotification;
- (void) addBook : (Book *) book :(NSString *)resultNotification;
- (void) deleteBook : (NSMutableArray *) books :(NSString *)resultNotification;

- (NSURL *) getURL : (NSString *) action;

@end
