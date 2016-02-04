//
//  RegisterRequest.m
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "RegisterRequest.h"

@implementation RegisterRequest

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"username": @"username",
                                                       @"pwd": @"password",
                                                       @"client_id": @"clientId",
                                                       @"client_secret": @"clientSecret"
                                                       }];
}

@end
