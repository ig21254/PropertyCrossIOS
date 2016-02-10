//
//  ProfileWrapper.h
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "BaseWrapper.h"
#import "User.h"
#import "InfoResponse.h"

@interface ProfileWrapper : BaseWrapper

#pragma mark - Instance methods

- (void) getProfileWithCompletionHandler:(void (^)(User * user))completionHandler;

- (void) getInfoWithCompletionHandler:(void (^)(InfoResponse * response))completionHandler;

#pragma mark - Class methods

+ (ProfileWrapper *)sharedInstance;

@end
