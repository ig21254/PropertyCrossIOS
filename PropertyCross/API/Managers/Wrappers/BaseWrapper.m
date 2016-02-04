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


- (NSMutableURLRequest *)createRequestForService:(NSString *)service
                                   andHttpMethod:(NSString *)method
                                        andModel:(JSONModel *)model
{
    NSMutableURLRequest *request = [self createRequestForService:service];
    [request setHTTPMethod:method];
    if (model) {
        [request setHTTPBody:[model toJSONData]];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    
    return request;
}

- (void)runRequest:(NSURLRequest *)request
withCompletionHandler:(void (^)(NSDictionary *response, NSError *error))completionHandler
{
    NSURLSessionDataTask *dataTask = [[self getSessionManager] dataTaskWithRequest:request
                                                                 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                      {
                                          if (error) {
                                              completionHandler(nil, error);
                                          }
                                          else {
                                              completionHandler(responseObject, nil);
                                          }
                                      }];
    [dataTask resume];
}

@end
