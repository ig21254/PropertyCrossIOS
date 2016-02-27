//
//  PropertyDescriptionViewController.m
//  PropertyCross
//
//  Created by Master on 19/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertyDescriptionViewController.h"
#import "Comentario.h"
#import "UserDefaults.h"

@interface PropertyDescriptionViewController ()

@property (strong, nonatomic) NSMutableArray<Comentario *> * comments;
@property (strong, nonatomic) NSMutableArray<NSString *> * images;


@end

@implementation PropertyDescriptionViewController

#pragma Initializations
- (void) viewDidLoad
{
    self.comments = [[NSMutableArray alloc] init];
    self.images = [NSMutableArray arrayWithObjects:@"apartment1.jpg", @"apartment2.jpg", @"apartment3.jpg", @"apartment4.jpg", nil];
    
}

- (void) viewDidAppear:(BOOL)animated
{
    self.propertyTitle.text = self.property.titulo;
    self.footage.text = [NSString stringWithFormat:@"%.0f m2", self.property.metros];
    self.price.text = [NSString stringWithFormat:@"%.2f €", self.property.precio];
    if (self.property.descripcion != nil) {
        self.propertyDescription.text = self.property.descripcion;
    }
    if (self.property.comentarios != nil) {
        self.comments = [self.property.comentarios mutableCopy];
    }
    
    self.photo.image = [UIImage imageNamed:[self.images objectAtIndex:arc4random_uniform((int)[self.images count])]];
    
    [self loadFavoriteImage];
}


- (IBAction)selectAsFavorite:(id)sender {
    self.property.favorito = [NSNumber numberWithBool:![self.property.favorito boolValue]];
    
    if ([self.property.favorito boolValue]) {
        [Property storeProperty:self.property];
    } else {
        [Property deleteFavorite:self.property];
    }
    
    [self loadFavoriteImage];
}

- (void) loadFavoriteImage
{
    if ([UserDefaults getAccessToken]) {
        [self.favorite setEnabled:YES];
        if ([self.property.favorito boolValue]) {
            self.favorite.image = [UIImage imageNamed:@"starFilledWhite"];
        } else {
            self.favorite.image = [UIImage imageNamed:@"star"];
        }
    } else {
        [self.favorite setEnabled:NO];
    }
}

- (IBAction)addComment:(id)sender
{
    [self performSegueWithIdentifier:@"goToCommentFromDescription" sender:self];
}


#pragma TableView 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count];
}




    # warning TO-DO
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellComment" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}




@end
