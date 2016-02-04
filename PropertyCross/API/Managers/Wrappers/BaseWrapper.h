//
//  BaseWrapper.h
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"

@interface BaseWrapper : NSObject

- (AFURLSessionManager *)getSessionManager;
- (NSMutableURLRequest *)createRequestForService:(NSString *)service;

@end
