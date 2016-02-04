//
//  BaseRequest.m
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "BaseRequest.h"

@implementation BaseRequest

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"client_id": @"clientId",
                                                       @"client_secret": @"clientSecret"
                                                       }];
}

@end
