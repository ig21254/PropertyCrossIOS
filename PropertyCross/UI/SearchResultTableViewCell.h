//
//  SearchResultTableViewCell.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultTableViewCell : UITableViewCell

@property (weak) IBOutlet UIImageView * image;
@property (weak) IBOutlet UILabel * title;
@property (weak) IBOutlet UILabel * subtitle;
@property (weak) IBOutlet UILabel * price;

@end
