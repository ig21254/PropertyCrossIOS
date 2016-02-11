//
//  Property.m
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Property.h"

@implementation Property

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"alquiler": @"alquiler",
                                                       @"anteriorConsulta": @"anteriorConsulta",
                                                       @"ciudad": @"ciudad",
                                                       @"comentarios": @"comentarios",
                                                       @"cp": @"cp",
                                                       @"descripcion": @"descripcion",
                                                       @"direccion": @"direccion",
                                                       @"emailPropietario": @"emailPropietario",
                                                       @"telefonoPropietario": @"telefonoPropietario",
                                                       @"titulo": @"titulo",
                                                       @"latitud": @"latitud",
                                                       @"longitud": @"longitud",
                                                       @"metros": @"metros",
                                                       @"precio": @"precio"
                                                       }];
}

@end
