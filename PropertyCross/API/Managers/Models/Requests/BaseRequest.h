//
//  BaseRequest.h
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface BaseRequest : JSONModel

@property (strong, nonatomic) NSString *clientId;
@property (strong, nonatomic) NSString *clientSecret;

@end
