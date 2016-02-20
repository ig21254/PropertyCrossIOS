//
//  CommentResponse.h
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Comentario.h"

@interface CommentResponse : JSONModel

@property (strong, nonatomic) Comentario* comentario;
@property (strong, nonatomic) NSString * status;

@end
