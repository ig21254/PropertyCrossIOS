//
//  SearchResultTableViewCell.h
//  PropertyCross
//
//  Created by Master on 3/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"


@protocol SearchResultTableViewCellProtocol <NSObject>

@required
- (void) didRemove;


@end

@interface SearchResultTableViewCell : UITableViewCell

@property (weak) IBOutlet UIImageView * image;
@property (weak) IBOutlet UILabel * title;
@property (weak) IBOutlet UILabel * subtitle;
@property (weak) IBOutlet UILabel * price;
@property (weak) IBOutlet UILabel * footage;
@property (weak) IBOutlet UIButton * favorite;

@property (strong, nonatomic) Property * property;

@property (assign) id<SearchResultTableViewCellProtocol> delegate;

- (void) configureCellWithProperty:(Property *) property;

@end
