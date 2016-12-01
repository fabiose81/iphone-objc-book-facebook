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
                        NSLog(@"Error");
                    }
                    else
                    {
                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                        
                        switch ([httpResponse statusCode]) {
                            case 200:
                            {
                                
                                NSArray *arrayBooks = [NSJSONSerialization JSONObjectWithData:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                                
                                 [[NSNotificationCenter defaultCenter] postNotificationName:resultNotification object:arrayBooks];
                                
                                break;
                            }
                                
                            default:
                                 NSLog(@"Error");
                                break;
                        }
                        
                    }
                    
                }] resume];
    }



- (void) addBook : (Book *) book :(NSString *)resultNotification{
    
    self.uiUtils = [[UIUtils alloc] init];
    
    NSError *error;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getURL:@"addBook"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    [body setValue:[book title]  forKey:@"title"];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options:0 error:&error]];
    
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (error)
                    {
                        NSLog(@"Error");
                    }
                    else
                    {
                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                        
                        switch ([httpResponse statusCode]) {
                            case 200:
                            {
                               NSDictionary *book = [NSJSONSerialization JSONObjectWithData:[[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
                                
                               [[NSNotificationCenter defaultCenter] postNotificationName:resultNotification object:book];
                                
                                break;
                            }
                                
                            default:
                                NSLog(@"Error");
                                break;
                        }
                        
                    }
                    
                }] resume];
}

- (void) deleteBook : (NSMutableArray *) books :(NSString *)resultNotification{
    
    self.uiUtils = [[UIUtils alloc] init];
    
    NSError *error;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getURL:@"deleteBook"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    [body setValue:books  forKey:@"id"];
    
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options:0 error:&error]];
    
    
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (error)
                    {
                        NSLog(@"Error");
                    }
                    else
                    {
                        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
                        
                        switch ([httpResponse statusCode]) {
                            case 200:
                            {
                                [[NSNotificationCenter defaultCenter] postNotificationName:resultNotification object:nil];
                                
                                break;
                            }
                                
                            default:
                                NSLog(@"Error");
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
