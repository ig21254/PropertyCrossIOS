//
//  User.m
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "User.h"

@implementation User

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"nombre": @"nombre",
                                                       @"apellidos": @"apellidos",
                                                       @"email": @"email",
                                                       @"foto": @"foto",
                                                       @"notificacion": @"notificacion"
                                                       }];
}


@end
