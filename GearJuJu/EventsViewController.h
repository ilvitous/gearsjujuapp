//
//  EventsViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventManagerEventViewController.h"
#import "EquipmentManagerEventViewController.h"

@interface EventsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) NSString *bearer;
@property (weak, nonatomic) NSString *userRole;
@property (weak, nonatomic) IBOutlet UITableView *EventsTableView;


@end
