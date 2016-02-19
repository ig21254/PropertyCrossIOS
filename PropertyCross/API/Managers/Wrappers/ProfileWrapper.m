//
//  ProfileWrapper.m
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "ProfileWrapper.h"
#import "UserDefaults.h"

@implementation ProfileWrapper

- (void) getProfileWithCompletionHandler:(void (^)(User * user))completionHandler {
    NSString * accessToken = [UserDefaults getAccessToken];
    
    NSMutableURLRequest *request = [super createRequestForService:@"profile" andHttpMethod:@"GET" andModel:nil];
    [request addValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
    
    
    //NSLog(@"request: %@", request);
    
    [super runRequest:request withCompletionHandler:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completionHandler(false);
        }
        else {
            NSLog(@"Succeed: %@", response);
            User * user = [[User alloc] initWithDictionary:response error:nil];
            completionHandler(user);
        }
    }];
}

- (void) getInfoWithCompletionHandler:(void (^)(InfoResponse * response))completionHandler {
    NSString * accessToken = [UserDefaults getAccessToken];
    
    NSMutableURLRequest *request = [super createRequestForService:@"info" andHttpMethod:@"GET" andModel:nil];
    [request addValue:[NSString stringWithFormat:@"Bearer %@", accessToken] forHTTPHeaderField:@"Authorization"];
    
    
    //NSLog(@"request: %@", request);
    
    [super runRequest:request withCompletionHandler:^(NSDictionary *response, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            completionHandler(false);
        }
        else {
            NSLog(@"Succeed: %@", response);
            InfoResponse * info = [[InfoResponse alloc] initWithDictionary:response error:nil];
            completionHandler(info);
        }
    }];
}

+ (ProfileWrapper *)sharedInstance
{
    static ProfileWrapper *sharedProfileWrapper = nil;
    @synchronized(self) {
        if (!sharedProfileWrapper) {
            sharedProfileWrapper = [ProfileWrapper new];
        }
    }
    return sharedProfileWrapper;
}


@end
