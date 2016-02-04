//
//  LoginRequest.m
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "LoginRequest.h"

@implementation LoginRequest

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"username": @"username",
                                                       @"pwd": @"password",
                                                       @"grant_type": @"grantType",
                                                       @"client_id": @"clientId",
                                                       @"client_secret": @"clientSecret"
                                                       }];
}

@end
