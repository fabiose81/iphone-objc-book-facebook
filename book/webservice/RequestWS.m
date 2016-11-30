//
//  RequestWS.m
//  saudeinfantil
//
//  Created by Fabio Estrela on 21/07/14.
//  Copyright (c) 2014 br.com.firewave. All rights reserved.
//

#import "RequestWS.h"

@implementation RequestWS


- (void) getBooks :(NSString *)resultNotification{
    
    self.uiUtils = [[UIUtils alloc] init];
    
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[self getURL:@"getBooks"]];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [[session dataTaskWithRequest:urlRequest
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (error)
                    {
                        [self.uiUtils showAlertMessage:@"Connection": @"No connection with server!"];
                    }
                    else
                    {
                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                        
                        switch ([httpResponse statusCode]) {
                            case 200:
                            {
                                
                                NSArray *arrayBooks = [[NSJSONSerialization JSONObjectWithData:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL] objectForKey:@"return"];
                                
                                 [[NSNotificationCenter defaultCenter] postNotificationName:resultNotification object:arrayBooks];
                                
                                break;
                            }
                                
                            default:
                                [self.uiUtils showAlertMessage:@"Connection": @"Erro"];
                                break;
                        }
                        
                    }
                    
                }] resume];
    }

- (NSURL *) getURL : (NSString *) action{
    
    NSString *pathPlistWS = [[NSBundle mainBundle] pathForResource:@"rest_urls" ofType:@"plist"];
    NSDictionary *dictionaryResult = [[NSMutableDictionary alloc]initWithContentsOfFile:pathPlistWS];
    NSURL *url = [NSURL URLWithString:[NSLocalizedString([dictionaryResult objectForKey:@"url_book"], nil) stringByAppendingString: action]];
    
    return url;
}


@end
