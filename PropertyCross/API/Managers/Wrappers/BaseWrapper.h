//
//  BaseWrapper.h
//  practica_mdpa
//
//  Created by Lluis Montero on 04/02/16.
//  Copyright © 2016 LaSalle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

#import "AFNetworking.h"

@interface BaseWrapper : NSObject

- (AFURLSessionManager *)getSessionManager;
- (NSMutableURLRequest *)createRequestForService:(NSString *)service;

- (NSMutableURLRequest *)createRequestForService:(NSString *)service
                                   andHttpMethod:(NSString *)method
                                        andModel:(JSONModel *)model;

- (void)runRequest:(NSURLRequest *)request
withCompletionHandler:(void (^)(NSDictionary *response, NSError *error))completionHandler;

@end
