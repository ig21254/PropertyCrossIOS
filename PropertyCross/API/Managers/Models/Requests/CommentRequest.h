//
//  CommentRequest.h
//  PropertyCross
//
//  Created by Master on 20/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CommentRequest : JSONModel

@property (strong, nonatomic) NSString * texto;
@property (strong, nonatomic) NSString * imagen;
@property (strong, nonatomic) NSString * video;

@end
