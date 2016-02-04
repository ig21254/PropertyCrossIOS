//
//  LoginResponse.h
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface LoginResponse : JSONModel

@property (strong, nonatomic) NSString * accessToken;
@property (strong, nonatomic) NSNumber * expiresIn;
@property (strong, nonatomic) NSString * refreshToken;
@property (strong, nonatomic) NSString * tokenType;

@end
