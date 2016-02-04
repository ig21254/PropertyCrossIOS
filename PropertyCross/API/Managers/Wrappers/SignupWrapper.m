//
//  SignupWrapper.m
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "SignupWrapper.h"
#import "RegisterRequest.h"

@implementation SignupWrapper

- (void)registerWithUser:(NSString *)user
             andPassword:(NSString *)password
{
    RegisterRequest *registerRequest = [[RegisterRequest alloc] init];
    registerRequest.username = user;
    registerRequest.password = password;
    registerRequest.clientId = @"android";
    registerRequest.clientSecret = @"SomeRandomCharsAndNumbers";
    
    NSMutableURLRequest *request = [super createRequestForService:@"register/signup"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[registerRequest toJSONData]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request: %@", request);
    NSLog(@"registerRequest: %@", [registerRequest toJSONString]);
    
    NSURLSessionDataTask *dataTask = [[self getSessionManager] dataTaskWithRequest:request
                                                                 completionHandler:^(NSURLResponse *response, id responseObject, NSError *error)
                                      {
                                          if (error) {
                                              NSLog(@"Error: %@", error);
                                          }
                                          else {
                                              NSLog(@"Succeed: %@", responseObject);
                                          }
                                      }];
    [dataTask resume];
}

#pragma mark - Class methods

+ (SignupWrapper *)sharedInstance
{
    static SignupWrapper *sharedSignupWrapper = nil;
    @synchronized(self) {
        if (!sharedSignupWrapper) {
            sharedSignupWrapper = [SignupWrapper new];
        }
    }
    return sharedSignupWrapper;
}

@end
