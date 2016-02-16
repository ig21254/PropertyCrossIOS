//
//  PropertyResponse.h
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "PropertyRequest.h"
#import "Property.h"

@interface PropertySearchResponse : JSONModel

@property (strong, nonatomic) PropertyRequest<Optional> * criterio;
@property (strong, nonatomic) NSArray<Property> * datos;
@property (strong, nonatomic) NSString * page;
@property (readwrite) int pageSize;
@property (strong, nonatomic) NSString * status;
@property (readwrite) int total;


@end
