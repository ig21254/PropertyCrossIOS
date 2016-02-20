//
//  CommentResponse.m
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "CommentResponse.h"

@implementation CommentResponse

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"comentario": @"comentario",
                                                       @"status": @"status"
                                                       }];
}

@end
