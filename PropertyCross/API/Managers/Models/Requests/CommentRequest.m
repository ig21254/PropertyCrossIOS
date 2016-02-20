//
//  CommentRequest.m
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "CommentRequest.h"

@implementation CommentRequest

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"texto": @"texto",
                                                       @"imagen": @"imagen",
                                                       @"video": @"video"
                                                       }];
}

@end
