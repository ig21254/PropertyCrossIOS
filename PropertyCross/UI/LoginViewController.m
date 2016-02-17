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
#import "UserData.h"

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
    
}



- (IBAction)loginAction:(id)sender {
    
    [[LoginWrapper sharedInstance] loginWithUser:self.userName.text
                                     andPassword:self.password.text
                           withCompletionHandler:^(LoginResponse * response)
    {
        UIAlertController *alert;
        if (response) {
            [UserData storeUsername:self.userName.text andPassword:self.password.text];
            [self.delegate didLogin];
        }
        else {
            alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                        message:@"El login no se ha podido completar."
                                                 preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"ACEPTAR"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil]];
            [self presentViewController:alert
                               animated:true
                             completion:nil];
        }
        
    }];
}

- (IBAction)registerAction:(id)sender {
    [[SignupWrapper sharedInstance] registerWithUser:self.userName.text
                                         andPassword:self.password.text
                               withCompletionHandler:^(BOOL succeed)
    {
        if (succeed) {
            // USER IS REGISTERED
            [self loginAction:sender];
        }
        else {
            // REGISTRATION FAILED
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                           message:@"El registro no se ha podido completar."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            [alert addAction:[UIAlertAction actionWithTitle:@"ACEPTAR"
                                                      style:UIAlertActionStyleDefault
                                                    handler:nil]];
            [self presentViewController:alert
                               animated:true
                             completion:nil];
        }
    }];
}

- (IBAction)facebookLoginAction:(id)sender {
    
}

- (IBAction)twitterLoginAction:(id)sender {
    
}

@end
