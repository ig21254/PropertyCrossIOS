//
//  UserDefaults.m
//  PropertyCross
//
//  Created by Master on 4/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "UserDefaults.h"

@implementation UserDefaults

+ (void) storeAccessToken:(NSString *)accessToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:KEY_ACCESS_TOKEN];
    [defaults synchronize];
}

+ (NSString *) getAccessToken {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_ACCESS_TOKEN];
}


@end
