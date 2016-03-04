//
//  LoginViewController.h
//  PropertyCross
//
//  Created by Master on 2/2/16.
//  Copyright © 2016 La Salle Master. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol LoginViewProtocol <NSObject>

@required
- (void) didLogin;


@end

@interface LoginViewController : UIViewController<
UITextFieldDelegate,
FBSDKLoginButtonDelegate>

@property (weak) IBOutlet UITextField *userName;
@property (weak) IBOutlet UITextField *password;

@property (weak) IBOutlet UIButton *btnLogin;
@property (weak) IBOutlet UIButton *btnRegister;

@property (weak) IBOutlet FBSDKLoginButton *btnFacebookLogin;
@property (weak) IBOutlet UIButton *btnTwitterLogin;

@property (assign) id<LoginViewProtocol> delegate;

@end
