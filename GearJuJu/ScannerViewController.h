//
//  ScannerViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/20/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Captuvo.h"
#import "AppDelegate.h"
#import "AssignViewController.h"

@interface ScannerViewController : UIViewController <CaptuvoEventsProtocol>

@property (weak, nonatomic) IBOutlet UIView *popUp;
@property (weak, nonatomic) IBOutlet UIButton *DismissButton;
@property (weak, nonatomic) IBOutlet UILabel *actionLabel;
@property (weak, nonatomic) IBOutlet UILabel *readyLabel;


@property (weak, nonatomic) IBOutlet UILabel *responseLabel;


@property (strong, nonatomic) NSString *action;
@property (strong, nonatomic) NSString *response;


//response view ckeckin
@property (weak, nonatomic) IBOutlet UIView *checkinResponseView;
@property (weak, nonatomic) IBOutlet UILabel *checkinEventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkinAssociateNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkinFieldNameLabel;


//response view assign
@property (weak, nonatomic) IBOutlet UIView *assignResponseView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;


//consign
@property (weak, nonatomic) IBOutlet UIView *consignResponseView;
@property (weak, nonatomic) IBOutlet UILabel *abiLabel;
@property (strong, nonatomic) NSString *abiNumber;
@property (weak, nonatomic) IBOutlet UILabel *equipmentIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *equipmentNameLabel;
@property (strong, nonatomic) NSString *equipment_id;
@property (weak, nonatomic) IBOutlet UILabel *successConsignLabel;


//error
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (strong, nonatomic) NSString *status;


//assign
@property (strong, nonatomic) NSString *event;
@property (strong, nonatomic) NSString *equipment_request;
@property (strong, nonatomic) NSString *gear_request;
@property (strong, nonatomic) NSString *requesterID;



@end
