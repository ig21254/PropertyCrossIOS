//
//  InfoResponse.m
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "InfoResponse.h"

@implementation InfoResponse

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"name": @"name",
                                                       @"scope": @"scope",
                                                       @"user_id": @"userId"
                                                       }];
}

@end
