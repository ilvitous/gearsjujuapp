//
//  EventManagerEventViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/18/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "EventManagerEventViewController.h"

@interface EventManagerEventViewController ()
@property (nonatomic,strong) NSMutableArray *event;
@property (nonatomic,strong) NSMutableArray *equipment;

@end

@implementation EventManagerEventViewController
@synthesize TitleLabel;
@synthesize event_title;
@synthesize action;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.AssignedEquipmentTableView.delegate = self;
    self.AssignedEquipmentTableView.dataSource = self;
    self.AssignedEquipmentTableView.backgroundColor = [UIColor clearColor];
    
    [self get_the_event];
    
    
}


-(void)get_the_event{
    
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/events/event"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:bearer forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *dictionary = @{@"id": self.event_id};
    
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
                       
                        self.event = [[NSMutableArray alloc] init];
                        self.event = [jsonOutput valueForKey:@"data"];
                        
                        self.equipment = [[NSMutableArray alloc] init];
                        self.equipment = [jsonOutput valueForKey:@"equipments"];
                        
                        self.TitleLabel.text = [self.event valueForKey:@"title"];
                        self.event_title = [self.event valueForKey:@"title"];
                        self.pNumberLabel.text = [self.event valueForKey:@"p_number"];
                        
                         [self.AssignedEquipmentTableView reloadData];
                        
                        
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


//table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.equipment count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [[self.equipment objectAtIndex:section] valueForKey:@"category"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ [[self.equipment objectAtIndex:section] valueForKey:@"equipments"]  count];
}






- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.AssignedEquipmentTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *eqipmentArray = [[self.equipment objectAtIndex:indexPath.section] valueForKey:@"equipments"];
    NSDictionary *json = [ [eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"user"];
    
    
    
    //    title
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    //assigned to
    UILabel *assignedLabel = (UILabel *)[cell viewWithTag:2];
    assignedLabel.text = [json valueForKey:@"name"];
    
//    consigned to
    
    NSString *consigend_to = @"";
    
    consigend_to = [NSString stringWithFormat:@"%@ @ %@" , [[eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"assigned_to"] , [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"chekout_date"]];
    
    
    if([consigend_to length]>15){
        UILabel *consignedLabel = (UILabel *)[cell viewWithTag:3];
        consignedLabel.text = consigend_to;
    }
 
    

    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; // your dynamic height...
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
   
    
    
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor whiteColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//scanner

- (IBAction)openScannerConsign:(id)sender {
    self.action = [NSString stringWithFormat:@"consign"];
    [self performSegueWithIdentifier:@"modalScannerConsign" sender:self];
}



//button actions

- (IBAction)back:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}




- (IBAction)makeRequest:(id)sender {
    [self performSegueWithIdentifier:@"requestModalSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"requestModalSegue"]) {
        AddRequestViewController *destViewController = segue.destinationViewController;
        destViewController.event_id = self.event_id;
        destViewController.event_title = self.event_title;
    }
    
    if ([segue.identifier isEqualToString:@"modalScannerConsign"]) {
        ScannerViewController *destViewController = segue.destinationViewController;
        destViewController.action = self.action;
        destViewController.event = self.event_id;
    }
    
    
}




@end
