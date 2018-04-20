//
//  LoginViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Captuvo.h"
#import "AppDelegate.h"



@interface LoginViewController : UIViewController<UITextFieldDelegate,CaptuvoEventsProtocol>

@property (strong, nonatomic) UIAlertController *alert;

@property (weak, nonatomic) IBOutlet UITextField *EmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *PasswordTextField;



@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *password;


//scanner
@property (weak, nonatomic) UIDevice *device ;
@property (weak, nonatomic) IBOutlet UILabel *debugLabel;


@end
