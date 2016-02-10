//
//  InfoResponse.h
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InfoResponse : JSONModel

@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * scope;
@property (strong, nonatomic) NSString * userId;

@end
