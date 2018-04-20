//
//  EquipmentManagerEventViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "EquipmentManagerEventViewController.h"

@interface EquipmentManagerEventViewController ()
@property (nonatomic,strong) NSMutableArray *event;

@property (nonatomic,strong) NSMutableArray *requests;


@end

@implementation EquipmentManagerEventViewController
@synthesize TitleLabel;
@synthesize pNumberLabel;
@synthesize event_id;
@synthesize event_title;
@synthesize requestsTableView;
@synthesize equipment;
@synthesize requesterName;
@synthesize requestDate;
@synthesize request_id;
@synthesize assigned;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.requestsTableView.delegate = self;
    self.requestsTableView.dataSource = self;
    self.requestsTableView.backgroundColor = [UIColor clearColor];
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
                        
                       
                        self.TitleLabel.text = [self.event valueForKey:@"title"];
                        self.event_title = [self.event valueForKey:@"title"];
                        self.pNumberLabel.text = [self.event valueForKey:@"p_number"];
                        
                        [self get_the_requests];
                        
                        
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




-(void)get_the_requests{
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
                        
                        [self.requestsTableView reloadData];
                        
                       
                        
                        
                        
                        
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
    
    
    NSDictionary *user = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"user"];
    
    
    
    
    //    title
    
    
    NSString *date = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"created_at"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *requestedDate = [dateFormatter dateFromString:date];
   
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    
    NSString *requestDateString = [dateFormatter stringFromDate:requestedDate];
    NSString *requesterName = [user valueForKey:@"name"];
    
    
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = requesterName;
    
    UILabel *timeLabel = (UILabel *)[cell viewWithTag:2];
    timeLabel.text = requestDateString;
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70; // your dynamic height...
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    self.equipment = [[self.requests objectAtIndex:indexPath.row] valueForKey:@"equipment"];
    self.assigned = [[self.requests objectAtIndex:indexPath.row] valueForKey:@"assigned"];
    
//    name
    NSDictionary *user = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"user"];
    self.requesterName = [user valueForKey:@"name"];
    
//date

    NSString *date = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"created_at"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *requestedDate = [dateFormatter dateFromString:date];
    [dateFormatter setDateFormat:@"MM/dd/yyyy hh:mm a"];
    self.requestDate = [dateFormatter stringFromDate:requestedDate];
    self.request_id = [ [self.requests objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    
    
    [self performSegueWithIdentifier:@"reqestAssignSegue" sender:self];
    [self.requestsTableView deselectRowAtIndexPath:[self.requestsTableView  indexPathForSelectedRow] animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    EquipmentManagerAssignViewController *destViewController = segue.destinationViewController;
    
    destViewController.event_id = self.event_id;
    destViewController.equipment = self.equipment;
    destViewController.requesterName = self.requesterName;
    destViewController.requestDate = self.requestDate;
    destViewController.request_id = self.request_id;
    destViewController.assigned = self.assigned;
    
    
    
    
}




- (IBAction)back:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
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

@end
