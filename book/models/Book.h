//
//  Book.h
//  book
//
//  Created by Fabio Estrela on 29/11/16.
//  Copyright © 2016 Fabio Estrela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property(strong,nonatomic)  NSString *idBook;
@property(strong,nonatomic)  NSString *title;
@property BOOL checked;

@end
