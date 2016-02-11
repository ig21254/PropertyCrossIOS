//
//  PropertyResponse.m
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertySearchResponse.h"

@implementation PropertySearchResponse

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"criterio": @"criterio",
                                                       @"datos": @"datos",
                                                       @"page": @"page",
                                                       @"pageSize": @"pageSize",
                                                       @"status": @"status",
                                                       @"total": @"total"
                                                       }];
}

@end
