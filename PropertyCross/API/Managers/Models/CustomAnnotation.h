//
//  CustomAnnotation.h
//  PropertyCross
//
//  Created by Master on 11/3/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Property.h"


@interface CustomAnnotation : NSObject <MKAnnotation>{
    
    NSString *title;
    NSString *subtitle;
    NSString *note;
    CLLocationCoordinate2D coordinate;
}

@property (nonatomic, copy) NSString * title;
@property (nonatomic, copy) NSString * subtitle;
@property (nonatomic, assign)CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) Property * property;
@property (readwrite) NSInteger position;

@end
