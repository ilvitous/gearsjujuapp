//
//  AssignViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScannerViewController.h"

@interface AssignViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *assignedEquipmentTableView;

//DATA TO PASS
@property (strong, nonatomic) NSString *event_id;
@property (strong, nonatomic) NSString *event_title;
@property (strong, nonatomic) NSString *equipment_request;
@property (strong, nonatomic) NSString *requesterID;


@property (strong, nonatomic) NSString *equipmentName;
@property (strong, nonatomic) NSString *requestQty;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *request_id;


@property (weak, nonatomic) IBOutlet UILabel *equipmentNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;


@property (strong, nonatomic) NSString *action;


@end
