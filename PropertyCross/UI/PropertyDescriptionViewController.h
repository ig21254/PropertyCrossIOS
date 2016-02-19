//
//  PropertyDescriptionViewController.h
//  PropertyCross
//
//  Created by Master on 19/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PropertyDescriptionViewController : UITableViewController<
UITableViewDataSource,
UITableViewDelegate>

@property (weak) IBOutlet UIImageView * photo;
@property (weak) IBOutlet UILabel * propertyTitle;
@property (weak) IBOutlet UILabel * footage;
@property (weak) IBOutlet UILabel * price;
@property (weak) IBOutlet UITextView * propertyDescription;
@property (weak) IBOutlet UITableView * coments;

@end
