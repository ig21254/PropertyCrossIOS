//
//  AddCommentViewController.m
//  PropertyCross
//
//  Created by Master on 27/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "AddCommentViewController.h"
#import "UserData.h"

@interface AddCommentViewController ()

@end

@implementation AddCommentViewController


- (void) viewDidAppear:(BOOL)animated
{
    UserData * user = [UserData getUserInfo];
    if (user) {
        self.username.text = user.username;
    }
}


- (IBAction)cancelComment:(id)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
}

@end
