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
#import "UserDefaults.h"

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
- (void) viewDidLoad
{
    self.btnFacebookLogin.readPermissions = @[@"public_profile", @"email"];
    self.btnFacebookLogin.delegate = self;
}


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


- (IBAction)twitterLoginAction:(id)sender {
    
}


- (void) loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
               error:	(NSError *)error {
    NSLog(@"Logged in!");
    
    if (!error) {
        
        FBSDKGraphRequest * request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"name, id, email, picture, first_name, last_name"}];
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            
            if (!error) {
                NSLog(@"RESULT: %@", result);
                [UserData storeUsername:[result valueForKey:@"name"]
                                andName:[result valueForKey:@"first_name"]
                            andLastName:[result valueForKey:@"last_name"]
                               andEmail:[result valueForKey:@"email"]];
                
                
                // As the API doesn't support Facebook Login functionality, we shall login using a "Default" user.
                [[LoginWrapper sharedInstance] loginWithUser:@"edu"
                                                     andPassword:@"edu"
                                           withCompletionHandler:^(LoginResponse * response)
                 {
                     [self.delegate didLogin];
                 }];
                
            }
        }];
        
        
        
    }
    
}

- (void) loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    [UserDefaults storeAccessToken:nil];
}


@end
