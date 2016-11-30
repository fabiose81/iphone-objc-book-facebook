//
//  ConexaoUtil.m
//  Sebraetec
//
//  Created by Fabio Estrela on 14/08/15.
//  Copyright (c) 2015 Sebrae. All rights reserved.
//

#import "ConexaoUtil.h"

@implementation ConexaoUtil

- (BOOL) statusInternet
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(!(status == NotReachable))
    {
        return  YES;
    }
    else
    {
        return NO;
    }
    
}

@end
