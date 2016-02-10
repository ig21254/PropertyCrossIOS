//
//  Notificacion.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Notificacion.h"

@implementation Notificacion

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"activa": @"activa",
                                                       @"ciudad": @"ciudad",
                                                       @"cp": @"cp",
                                                       @"direccion": @"direccion",
                                                       @"radio": @"radio",
                                                       @"radioUnidad": @"radioUnidad"
                                                       }];
}


@end
