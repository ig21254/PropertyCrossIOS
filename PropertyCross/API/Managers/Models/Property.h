//
//  Property.h
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Comentario

@end

@interface Property : JSONModel

@property (readwrite) BOOL alquiler;
@property (readwrite) long anteriorConsulta;
@property (strong, nonatomic) NSString *ciudad;
@property (strong, nonatomic) NSArray<Comentario> *comentarios;
@property (strong, nonatomic) NSString * cp;
@property (strong, nonatomic) NSString * descripcion;
@property (strong, nonatomic) NSString * direccion;
@property (strong, nonatomic) NSString * emailPropietario;
@property (strong, nonatomic) NSString * telefonoPropietario;
@property (strong, nonatomic) NSString * titulo;
@property (readwrite) double latitud;
@property (readwrite) double longitud;
@property (readwrite) double metros;
@property (readwrite) double precio;


@end
