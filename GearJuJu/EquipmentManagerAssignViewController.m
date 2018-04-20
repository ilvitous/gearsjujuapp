//
//  EquipmentManagerAssignViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "EquipmentManagerAssignViewController.h"

@interface EquipmentManagerAssignViewController ()
@property (nonatomic,strong) NSMutableArray *requests;
@property (nonatomic,strong) NSMutableArray *assignedArray;


@end

@implementation EquipmentManagerAssignViewController

@synthesize event_id;
@synthesize equipment;
@synthesize requesterName;
@synthesize requesterID;
@synthesize requestDate;
@synthesize request_id;
@synthesize equipment_request;

@synthesize requesterNameLabel;
@synthesize requestDateLabel;
@synthesize requestsTableView;

@synthesize equipmentName;
@synthesize requestQty;
@synthesize category;
@synthesize assigned;





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.requesterNameLabel.text = self.requesterName;
    self.requestDateLabel.text = self.requestDate;
    
    
    if( ![self.assigned isEqual:[NSNull null]] ){
        
        self.assignedArray = [[NSMutableArray alloc] init];
        NSError *error;
        NSData *data = [self.assigned dataUsingEncoding:NSUTF8StringEncoding];
        self.assignedArray = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data  options:kNilOptions error:&error];
    }
    
    
    NSData *data = [self.equipment dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    self.requests = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data  options:kNilOptions error:&error];
    
    
    
    
    self.requestsTableView.delegate = self;
    self.requestsTableView.dataSource = self;
    self.requestsTableView.backgroundColor = [UIColor clearColor];
    
    [self.requestsTableView reloadData];
    
    self.navigationController.delegate = self;
    
}


- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"AAA");
    [self.requestsTableView reloadData];
}


//table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.requests count];
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.requestsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    //    equipment name
    NSString *equipmentName = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"name"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = equipmentName ;
    
    
//    qty
    NSString *qty = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"qty"];
    UILabel *qtyLabel = (UILabel *)[cell viewWithTag:2];
    
    
    
//    assigned qty
    
    NSInteger count = 0;
    if( [self.assignedArray count] > 0 ){
        NSString *equipmentRequest  = [[self.requests objectAtIndex:indexPath.row] valueForKey:@"equipment_request"];
        for (id device in self.assignedArray) {
            if( [[device valueForKey:@"equipment_request"] isEqualToString: equipmentRequest]  ){
                count++;
            }
        }
    }
    
    NSString *string = [NSString stringWithFormat:@"%zd", count];
    
    NSString *qtyString = [NSString stringWithFormat:@"  REQUESTED: %@ | ASSIGNED: %@",qty, string ];
    
    NSInteger qtyNumber = [qty integerValue];
    
    if( count >= qtyNumber){
        qtyLabel.backgroundColor = [UIColor colorWithRed:(0.2) green:(0.5) blue:(0) alpha:1];
    }else{
        qtyLabel.backgroundColor = [UIColor colorWithRed:(0.75) green:(0) blue:(0) alpha:1];
    }
    qtyLabel.text = qtyString;
    
    //    category
    NSString *category = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"category"];
    UILabel *categoryLabel = (UILabel *)[cell viewWithTag:3];
    NSString *categoryString = [NSString stringWithFormat:@"Category: %@",category];
    categoryLabel.text = categoryString;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; // your dynamic height...
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.equipment_request = [[self.requests objectAtIndex:indexPath.row] valueForKey:@"equipment_request"];
    self.equipmentName = [[self.requests objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    NSString *qty = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"qty"];
    self.requestQty = [NSString stringWithFormat:@"Requested: %@",qty];
    
    NSString *category = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"category"];
    self.category = [NSString stringWithFormat:@"Category: %@",category];
    
    [self performSegueWithIdentifier:@"assignViewSegue" sender:self];
    
    
    [self.requestsTableView deselectRowAtIndexPath:[self.requestsTableView  indexPathForSelectedRow] animated:YES];


}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"assignViewSegue"]) {
        AssignViewController *destViewController = segue.destinationViewController;
        destViewController.equipment_request = self.equipment_request;
        destViewController.equipmentName = self.equipmentName;
        destViewController.requestQty = self.requestQty;
        destViewController.category = self.category;
        destViewController.event_id = self.event_id;
        destViewController.request_id = self.request_id;
        destViewController.requesterID = self.requesterID;
        
        
        
        
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
