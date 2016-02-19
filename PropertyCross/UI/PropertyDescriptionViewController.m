//
//  PropertyDescriptionViewController.m
//  PropertyCross
//
//  Created by Master on 19/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "PropertyDescriptionViewController.h"
#import "Comentario.h"

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
}



#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.comments count];
}




    # warning TO-DO
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellComment" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
