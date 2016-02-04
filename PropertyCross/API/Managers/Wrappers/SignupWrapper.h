//
//  SignupWrapper.h
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "BaseWrapper.h"

@interface SignupWrapper : BaseWrapper

#pragma mark - Instance methods

- (void)registerWithUser:(NSString *)user
             andPassword:(NSString *)password;

#pragma mark - Class methods

+ (SignupWrapper *)sharedInstance;

@end
