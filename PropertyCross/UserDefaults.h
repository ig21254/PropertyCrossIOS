//
//  UserDefaults.h
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaults : NSObject


+ (void) storeAccessToken:(NSString *)accessToken;
+ (NSString* ) getAccessToken;

@end
