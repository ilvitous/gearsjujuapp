//
//  EventManagerEventViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/18/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddRequestViewController.h"
#import "ScannerViewController.h"


@interface EventManagerEventViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSString *event_id;
@property (strong, nonatomic) NSString *event_title;
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *pNumberLabel;

@property (weak, nonatomic) IBOutlet UITableView *AssignedEquipmentTableView;

@property (strong, nonatomic) NSString *action;


@end
