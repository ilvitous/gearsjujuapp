//
//  AssignViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "AssignViewController.h"

@interface AssignViewController ()
@property (nonatomic,strong) NSMutableArray *requests;
@property (nonatomic,strong) NSMutableArray *equipmentFiltered;
@property (nonatomic,strong) NSMutableArray *assignedDevice;
@end

@implementation AssignViewController
@synthesize assignedEquipmentTableView;

@synthesize event_id;
@synthesize event_title;
@synthesize equipment_request;

@synthesize equipmentNameLabel;
@synthesize requestQtyLabel;
@synthesize categoryLabel;

@synthesize equipmentName;
@synthesize requestQty;
@synthesize category;
@synthesize action;

@synthesize request_id;

@synthesize requesterID;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.assignedEquipmentTableView.delegate = self;
    self.assignedEquipmentTableView.dataSource = self;
    self.assignedEquipmentTableView.backgroundColor = [UIColor clearColor];
    self.equipmentNameLabel.text = self.equipmentName;
    self.requestQtyLabel.text = self.requestQty;
    self.categoryLabel.text = self.category;
    [self get_assigned_equipments];
    
   
 
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
     [[NSNotificationCenter defaultCenter] removeObserver:self];
    // unregister for keyboard notifications while not visible.

}

- (void)reloadTableFromAssign
{
    // this method gets called in MainVC when your SecondVC is dismissed
    [self get_assigned_equipments];
}






-(void)get_assigned_equipments{
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/request/all"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:bearer forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *dictionary = @{@"event_id": self.event_id};
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    NSURLSession *session = [NSURLSession sharedSession];
    
    if (!error) {
        // 4
        NSURLSessionDataTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
            id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSString *status = [jsonOutput valueForKey:@"status"];
            NSString *msg = [jsonOutput valueForKey:@"msg"];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[NSThread currentThread] isMainThread]){
                    NSLog(@"In main thread--completion handler");
                    //
                    if( [status isEqualToString:@"success"]  ){
                        
                       
                        
                        self.requests = [[NSMutableArray alloc] init];
                        self.requests = [jsonOutput valueForKey:@"data"];
                        
                        [self filter_equipment];
                        
                        
                        
                    }else{
                        NSLog(@"Status: %@",status);
                        NSLog(@"Message: %@",msg);
                    }
                    
                }
                else{
                    NSLog(@"Not in main thread--completion handler");
                }
            });
            
            
        }];
        [uploadTask resume];
    }
    
    
    
}

-(void) filter_equipment{
    
    self.assignedDevice = [[NSMutableArray alloc]init];
    
    
    if( [self.requests count]>0){
        
        for (id request in self.requests) {
            NSString *assign = [request valueForKey:@"assigned"];
            
            if( ![assign isEqual:[NSNull null]] ){
                
                NSData *data = [assign dataUsingEncoding:NSUTF8StringEncoding];
                NSError *error;
                NSMutableArray *assignedToRequest = [[NSMutableArray alloc] init];
                assignedToRequest = (NSMutableArray*)[NSJSONSerialization JSONObjectWithData:data  options:kNilOptions error:&error];
                
                
                
                    for (id device in assignedToRequest) {
                        
                        if( [[device valueForKey:@"equipment_request"] isEqualToString: self.equipment_request]  ){
                             [self.assignedDevice addObject:device];
                        }
                        
                        
                    
                    
                    }


            }
            

        }
        
        
        

    }
    
    
    [self.assignedEquipmentTableView reloadData];
    
    
}


//table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.assignedDevice count];
    
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.assignedEquipmentTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    //    equipment name
    NSString *equipmentName = [ [self.assignedDevice objectAtIndex:indexPath.row] valueForKey:@"name"];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = equipmentName ;
    
    
    //    assigned date
    
    NSDictionary *assignedDate = [ [self.assignedDevice objectAtIndex:indexPath.row] valueForKey:@"assign_date"];
    NSString *date = [assignedDate valueForKey:@"date"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    NSDate *requestedDate = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:2];
    dateLabel.text = [dateFormatter stringFromDate:requestedDate];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75; // your dynamic height...
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)back:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}


//scanner

- (IBAction)openSacnner:(id)sender {
    
    
    // Set self to listen for the message "SecondViewControllerDismissed"
    // and run a method when this message is detected
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(reloadTableFromAssign)
     name:@"AssignSuccess"
     object:nil];
    
    
    self.action = [NSString stringWithFormat:@"assign"];
    [self performSegueWithIdentifier:@"modalScannerSegue" sender:self];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"modalScannerSegue"]) {
        ScannerViewController *destViewController = segue.destinationViewController;
        destViewController.action = self.action;
        destViewController.event = self.event_id;
        destViewController.equipment_request = self.equipment_request;
        destViewController.gear_request = self.request_id;
        destViewController.requesterID = self.requesterID;
    }
    
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
