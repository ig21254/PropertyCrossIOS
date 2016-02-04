//
//  LoginWrapper.m
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "LoginWrapper.h"
#import "LoginRequest.h"

@implementation LoginWrapper

- (void)loginWithUser:(NSString *)user
          andPassword:(NSString *)password
{
    LoginRequest *loginRequest = [[LoginRequest alloc] init];
    loginRequest.username = user;
    loginRequest.password = password;
    loginRequest.clientId = @"android";
    loginRequest.clientSecret = @"SomeRandomCharsAndNumbers";
    loginRequest.grantType = @"password";
    
    NSMutableURLRequest *request = [super createRequestForService:@"oauth/token"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[loginRequest toJSONData]];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    NSLog(@"request: %@", request);
    NSLog(@"loginRequest: %@", [loginRequest toJSONString]);
    
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

+ (LoginWrapper *)sharedInstance
{
    static LoginWrapper *sharedSignupWrapper = nil;
    @synchronized(self) {
        if (!sharedSignupWrapper) {
            sharedSignupWrapper = [LoginWrapper new];
        }
    }
    return sharedSignupWrapper;
}


@end
