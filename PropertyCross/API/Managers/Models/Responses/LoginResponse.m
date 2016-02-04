//
//  LoginResponse.m
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "LoginResponse.h"

@implementation LoginResponse

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"access_token": @"accessToken",
                                                       @"expires_in": @"expiresIn",
                                                       @"refresh_token": @"refreshToken",
                                                       @"token_type": @"tokenType"
                                                       }];
}

@end
