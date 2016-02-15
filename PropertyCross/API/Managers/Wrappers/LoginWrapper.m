//
//  LoginWrapper.m
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "LoginWrapper.h"
#import "LoginRequest.h"
#import "UserDefaults.h"

@implementation LoginWrapper

- (void)loginWithUser:(NSString *)user
          andPassword:(NSString *)password
withCompletionHandler:(void (^)(LoginResponse * loginResponse))completionHandler
{
    LoginRequest *loginRequest = [[LoginRequest alloc] init];
    loginRequest.username = user;
    loginRequest.password = password;
    loginRequest.clientId = @"android";
    loginRequest.clientSecret = @"SomeRandomCharsAndNumbers";
    loginRequest.grantType = @"password";
    
    NSMutableURLRequest *request = [super createRequestForService:@"oauth/token" andHttpMethod:@"POST" andModel:loginRequest];
    
    NSLog(@"request: %@", request);
    NSLog(@"loginRequest: %@", [loginRequest toJSONString]);
    
    [super runRequest:request withCompletionHandler:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completionHandler(false);
        }
        else {
            //NSLog(@"Succeed: %@", response[@"access_token"]);
            //NSLog(@"Succeed: %@", response);
            [UserDefaults storeAccessToken:response[@"access_token"]];
            LoginResponse * loginResponse = [[LoginResponse alloc] initWithDictionary:response error:nil];
            completionHandler(loginResponse);
        }
    }];
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
