//
//  BaseWrapper.m
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "BaseWrapper.h"

#define SERVICES_URL @"https://push.opentrends.net:8100/mdpa/api/"

@interface BaseWrapper() {
    AFURLSessionManager *sessionManager;
}

@end

@implementation BaseWrapper

- (AFURLSessionManager *)getSessionManager
{
    if(!sessionManager) {
        sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    return sessionManager;
}

- (NSMutableURLRequest *)createRequestForService:(NSString *)service
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", SERVICES_URL, service]];
    return [NSMutableURLRequest requestWithURL:url];
}

@end
