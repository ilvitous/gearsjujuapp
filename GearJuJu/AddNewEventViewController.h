//
//  AddNewEventViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/18/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNewEventViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *EventNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *PnumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *AddressTextField;

@property (weak, nonatomic) IBOutlet UITextField *DateStartTextField;
@property (weak, nonatomic) IBOutlet UITextField *DateEndTextField;


@property (strong, nonatomic) NSString *StartDate;
@property (strong, nonatomic) NSString *EndDate;


@property (strong, nonatomic) NSString *EventName;
@property (strong, nonatomic) NSString *Address;
@property (strong, nonatomic) NSString *PNumber;

@end
