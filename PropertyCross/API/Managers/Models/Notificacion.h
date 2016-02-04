//
//  Notificacion.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Notificacion : JSONModel

@property (readwrite) BOOL activa;
@property (strong, nonatomic) NSString * ciudad;
@property (strong, nonatomic) NSString * cp;
@property (strong, nonatomic) NSString * direccion;
@property (readwrite) int radio;
@property (strong, nonatomic) NSString * radioUnidad;

@end
