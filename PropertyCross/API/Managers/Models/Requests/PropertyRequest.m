//
//  PropertyRequest.m
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertyRequest.h"

@implementation PropertyRequest

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"alquiler": @"alquiler",
                                                       @"venta": @"venta",
                                                       @"latitud": @"latitud",
                                                       @"longitud": @"longitud",
                                                       @"query": @"query"
                                                       }];
}

@end
