//
//  LoginViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) UIAlertController *alert;

@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;



@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;



@end
