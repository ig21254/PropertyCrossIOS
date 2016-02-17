//
//  ProfileViewController.m
//  PropertyCross
//
//  Created by Master on 8/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "UserData.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UserData * user = [UserData getUserInfo];
    
    if (user) {
        self.username.text = user.username;
        self.password.text = user.password;
        self.confirmPassword.text = user.password;
        self.name.text = user.firstname;
        self.lastname.text = user.lastname;
        self.email.text = user.email;
        self.notification.selected = user.notifications;
    }
    
}

- (IBAction) saveProfile:(id)sender {
    User * user = [[User alloc] init];
    
    user.nombre = self.name.text;
    user.apellidos = self.lastname.text;
    user.email = self.email.text;
    
    [UserData storeSearchWithPropertyResponse:user andNotification:[self.notification isEnabled]];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


- (IBAction)cancelProfile:(id)sender
{
    [self dismissViewControllerAnimated:false completion:nil];
    [self performSegueWithIdentifier:@"goToPropertySearchFromProfile" sender:sender];
    
}



@end
