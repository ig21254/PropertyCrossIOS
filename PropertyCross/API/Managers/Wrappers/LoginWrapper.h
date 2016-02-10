//
//  LoginWrapper.h
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "BaseWrapper.h"
#import "LoginResponse.h"

@interface LoginWrapper : BaseWrapper

#pragma mark - Instance methods

- (void)loginWithUser:(NSString *)user
          andPassword:(NSString *)password
withCompletionHandler:(void (^)(LoginResponse * loginResponse))completionHandler;

#pragma mark - Class methods

+ (LoginWrapper *)sharedInstance;

@end
