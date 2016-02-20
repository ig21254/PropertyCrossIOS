//
//  SearchResultTableViewCell.m
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "SearchResultTableViewCell.h"
#import "UserDefaults.h"
#import "Favorite+CoreDataProperties.h"

@implementation SearchResultTableViewCell

- (void) configureCellWithProperty:(Property *) property
{
    self.title.text = property.titulo;
    
    if (property.alquiler) {
        self.subtitle.text = @"en alquiler";
    }
    else {
        self.subtitle.text = @"en venta";
    }
    
    self.price.text = [NSString stringWithFormat:@"%.2f €", property.precio];
    self.footage.text = [NSString stringWithFormat:@"%.2f m2", property.metros];
    
    self.image.contentMode = UIViewContentModeScaleAspectFit;
    self.image.image = [UIImage imageNamed:[NSString stringWithFormat:@"apartment%d.jpg", arc4random_uniform(4)+1]];
    
    self.property = property;
    
    [self loadFavoriteImage];
    
}

- (IBAction)selectAsFavorite:(id)sender {
    self.property.favorito = [NSNumber numberWithBool:![self.property.favorito boolValue]];
    
    if ([self.property.favorito boolValue]) {
        [Favorite storeFavorite:self.property];
    } else {
        Favorite * favorite = [[Favorite alloc] init];
        [favorite initWithProperty:self.property];
        [Favorite deleteFavorite:favorite];
    }
    
    [self loadFavoriteImage];
}

- (void) loadFavoriteImage
{
    if ([UserDefaults getAccessToken]) {
        [self.favorite setEnabled:YES];
        UIImage * image;
        if ([self.property.favorito boolValue]) {
            image = [UIImage imageNamed:@"starFilled"];
        } else {
            image = [UIImage imageNamed:@"star"];
        }
        [self.favorite setBackgroundImage:image forState:UIControlStateNormal];
    } else {
        [self.favorite setEnabled:NO];
    }
}



@end
