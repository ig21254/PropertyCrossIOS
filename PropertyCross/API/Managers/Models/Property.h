//
//  Property.h
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import <CoreData/CoreData.h>

@protocol Comentario

@end

@protocol Property
@end

@interface Property : JSONModel

@property (readwrite) BOOL alquiler;
@property (strong, nonatomic) NSNumber<Optional> * anteriorConsulta;
@property (strong, nonatomic) NSString * titulo;
@property (readwrite) double latitud;
@property (readwrite) double longitud;
@property (readwrite) double metros;
@property (readwrite) double precio;

@property (strong, nonatomic) NSNumber<Optional> * favorito;
@property (strong, nonatomic) NSString<Optional> * ciudad;
@property (strong, nonatomic) NSArray<Comentario, Optional> *comentarios;
@property (strong, nonatomic) NSString<Optional> * cp;
@property (strong, nonatomic) NSString<Optional> * descripcion;
@property (strong, nonatomic) NSString<Optional> * direccion;
@property (strong, nonatomic) NSString<Optional> * emailPropietario;
@property (strong, nonatomic) NSString<Optional> * telefonoPropietario;

@property (strong, nonatomic) NSDate<Optional> * timestamp;


+ (void) storeProperty:(Property * ) property;
+ (void) deleteFavorite:(Property *) property;
+ (NSMutableArray<Property *> *) getFavorites;
- (void) initEntity:(NSManagedObject *) entity;


@end

