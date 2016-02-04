//
//  LoginRequest.h
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "BaseRequest.h"

@interface LoginRequest : BaseRequest

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *grantType;

@end
