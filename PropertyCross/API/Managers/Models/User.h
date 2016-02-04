//
//  User.h
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Foto.h"
#import "Notificacion.h"

@interface User : JSONModel

@property (strong, nonatomic) NSString *nombre;
@property (strong, nonatomic) NSString *apellidos;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) Foto * foto;
@property (strong, nonatomic) Notificacion * notificacion;

@end
