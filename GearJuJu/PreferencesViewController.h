//
//  PreferencesViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *apiUrlTextField;


//preferences
@property (weak, nonatomic) NSString *apiUrl;



@end
