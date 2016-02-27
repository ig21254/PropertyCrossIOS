
//
//  Comentario.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "Comentario.h"

@implementation Comentario

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"autor": @"autor",
                                                       @"fecha": @"fecha",
                                                       @"texto": @"texto",
                                                       @"video": @"video",
                                                       @"foto" : @"foto"
                                                       }];
}

@end
