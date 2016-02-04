//
//  RegisterRequest.h
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import "BaseRequest.h"

@interface RegisterRequest : BaseRequest

@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;

@end
