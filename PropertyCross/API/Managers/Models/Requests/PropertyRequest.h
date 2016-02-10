//
//  PropertyRequest.h
//  PropertyCross
//
//  Created by Master on 10/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "BaseRequest.h"

@interface PropertyRequest : JSONModel

@property (readwrite) BOOL * alquiler;
@property (readwrite) BOOL * venta;
@property (readwrite) double latitud;
@property (readwrite) double longitud;


@end
