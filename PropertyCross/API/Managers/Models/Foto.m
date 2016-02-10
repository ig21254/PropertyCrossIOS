//
//  Foto.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Foto.h"

@implementation Foto

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"datos": @"datos",
                                                       @"tipo": @"tipo"
                                                       }];
}


@end
