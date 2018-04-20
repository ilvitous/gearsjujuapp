//
//  HomeViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScannerViewController.h"


@interface HomeViewController : UIViewController

@property (weak, nonatomic) NSString *bearer;
@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userRole;
@property (weak, nonatomic) IBOutlet UILabel *RoleLabel;
@property (weak, nonatomic) IBOutlet UILabel *UsernameLabel;
@property (weak, nonatomic) IBOutlet UIView *EventManagerView;
@property (weak, nonatomic) IBOutlet UIView *EquipmentManagerView;


@property (strong, nonatomic) NSString *action;


@end
