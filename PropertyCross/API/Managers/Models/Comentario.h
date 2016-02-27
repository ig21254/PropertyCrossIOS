//
//  Comentario.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface Comentario : JSONModel

@property (strong, nonatomic) NSString * autor;
@property (readwrite) long fecha;
@property (strong, nonatomic) NSString * texto;
@property (strong, nonatomic) NSString * video;
@property (strong, nonatomic) NSString<Optional> * foto;

@end
