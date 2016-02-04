//
//  LoginWrapper.h
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "BaseWrapper.h"

@interface LoginWrapper : BaseWrapper

#pragma mark - Instance methods

- (void)loginWithUser:(NSString *)user
             andPassword:(NSString *)password;

#pragma mark - Class methods

+ (LoginWrapper *)sharedInstance;

@end
