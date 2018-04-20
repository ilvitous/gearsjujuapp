//
//  EquipmentManagerAssignViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssignViewController.h"
@interface EquipmentManagerAssignViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>




@property (strong, nonatomic) NSString *event_id;
@property (strong, nonatomic) NSString *equipment;
@property (strong, nonatomic) NSString *requesterName;
@property (strong, nonatomic) NSString *requestDate;
@property (strong, nonatomic) NSString *request_id;

//DATA TO PASS
@property (strong, nonatomic) NSString *equipmentName;
@property (strong, nonatomic) NSString *requestQty;
@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString *equipment_request;
@property (strong, nonatomic) NSString *assigned;
@property (strong, nonatomic) NSString *requesterID;





@property (weak, nonatomic) IBOutlet UILabel *requesterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *requestDateLabel;


@property (weak, nonatomic) IBOutlet UITableView *requestsTableView;


@end
