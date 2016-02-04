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
   withCompletionHandler:(void (^)(BOOL succeed))completionHandler
{
    RegisterRequest *registerRequest = [[RegisterRequest alloc] init];
    registerRequest.username = user;
    registerRequest.password = password;
    registerRequest.clientId = @"android";
    registerRequest.clientSecret = @"SomeRandomCharsAndNumbers";
    
    NSMutableURLRequest *request = [super createRequestForService:@"register/signup" andHttpMethod:@"POST" andModel:registerRequest];
                                    
    NSLog(@"request: %@", request);
    NSLog(@"registerRequest: %@", [registerRequest toJSONString]);
    
    [super runRequest:request withCompletionHandler:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completionHandler(false);
        }
        else {
            NSLog(@"Succeed: %@", response);
            completionHandler(true);
        }
    }];
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
