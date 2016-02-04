//
//  LoginViewController.m
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginWrapper.h"
#import "SignupWrapper.h"

@implementation LoginViewController

#pragma mark - UITxtFieldDelegate implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.userName) {
        [self.password becomeFirstResponder];
    }
    else {
        [self.password endEditing:true];
        
    }
    return true;
}


#pragma mark - View lifecycle

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
                                                                   message:@"message"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"action"
                                             style:UIAlertActionStyleDefault
                                           handler:nil]];
    
    [self presentViewController:alert
                       animated:true
                     completion:nil];
}

- (IBAction)loginAction:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Login"
                                                                   message:[self.userName text]
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"action"
                                              style:UIAlertActionStyleDefault
                                            handler:nil]];
    
    [self presentViewController:alert
                       animated:true
                     completion:nil];
    
    [[LoginWrapper sharedInstance] loginWithUser:self.userName.text
                                     andPassword:self.password.text];
}

- (IBAction)registerAction:(id)sender {
    [[SignupWrapper sharedInstance] registerWithUser:self.userName.text
                                         andPassword:self.password.text];
    
}

- (IBAction)facebookLoginAction:(id)sender {
    
}

- (IBAction)twitterLoginAction:(id)sender {
    
}

@end
