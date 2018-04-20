//
//  EquipmentManagerEventViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquipmentManagerAssignViewController.h"

@interface EquipmentManagerEventViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;

@property (strong, nonatomic) NSString *event_id;
@property (strong, nonatomic) NSString *event_title;

@property (strong, nonatomic) NSString *equipment;
@property (strong, nonatomic) NSString *requesterName;
@property (strong, nonatomic) NSString *requesterID;
@property (strong, nonatomic) NSString *requestDate;
@property (strong, nonatomic) NSString *request_id;

@property (weak, nonatomic) IBOutlet UITableView *requestsTableView;


@property (strong, nonatomic) NSString *assigned;



@end
