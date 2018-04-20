//
//  EventsViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "EventsViewController.h"

@interface EventsViewController ()
@property (nonatomic,strong) NSMutableArray *events;
@property (nonatomic,strong) NSString *event_id;


@end

@implementation EventsViewController
@synthesize bearer;
@synthesize EventsTableView;
@synthesize userRole;
@synthesize AddNewEventButton;
@synthesize TableConstrain;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *bearer = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    self.bearer = [NSString stringWithFormat:@"Bearer %@", bearer];
    
    self.userRole = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserRole"];
    
    
    self.EventsTableView.delegate = self;
    self.EventsTableView.dataSource = self;
    self.EventsTableView.backgroundColor = [UIColor clearColor];
    
    
    
    [self get_all_events];
    
    if([self.userRole isEqualToString:@"Equipment Manager"]){
        self.AddNewEventButton.hidden = true;
        
        self.TableConstrain.constant = -50;
        [self.EventsTableView setNeedsUpdateConstraints];
    }
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self get_all_events];
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



//button action

- (IBAction)back:(id)sender {
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)addNewEvent:(id)sender {
    [self performSegueWithIdentifier:@"addNewEventSegue" sender:self];
    
}

-(void)get_all_events{
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/events/all"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:self.bearer forHTTPHeaderField:@"Authorization"];
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request
                                                  completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                      
                                                      id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                      
                                                      NSString *status = [jsonOutput valueForKey:@"status"];
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          if ([[NSThread currentThread] isMainThread]){
                                                              NSLog(@"In main thread--completion handler");
                                                              
                                                              if( [status isEqualToString:@"success"]  ){
                                                                  
                                                                  _events = [[NSMutableArray alloc] init];
                                                                  _events = [jsonOutput valueForKey:@"data"];
                                                                  [self.EventsTableView reloadData];
                                                              }else{
                                                                  NSLog(@"Status: %@",status);
                                                              }
                                                              
                                                          }
                                                          else{
                                                              NSLog(@"Not in main thread--completion handler");
                                                          }
                                                      });
                                                      
                                                      
                                                  }];
    
    
    // 5
    [uploadTask resume];
    
    
}


//table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [self.EventsTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    //    title
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:1];
    titleLabel.text = [[_events objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    
    //    dates
    
    NSString *dates =  [[_events objectAtIndex:indexPath.row] valueForKey:@"dates"];
    NSArray *arrayOfDates = [NSJSONSerialization JSONObjectWithData:[dates dataUsingEncoding:NSUTF8StringEncoding]
                                                          options:0 error:NULL];
    
    //    dates
    
    NSString *fullDate = @"";
    
    if([arrayOfDates count] > 1){
        
        NSString *fisrtDateString = arrayOfDates[0];
        NSString *lastDateString = arrayOfDates[([arrayOfDates count]-1)];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        NSDate *firstDate = [dateFormatter dateFromString:fisrtDateString];
        NSDate *lastDate = [dateFormatter dateFromString:lastDateString];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"]; // Date formater
        NSString *firstDateStringFormatted = [dateFormatter stringFromDate:firstDate];
        NSString *lastDateStringFormatted = [dateFormatter stringFromDate:lastDate];
        fullDate = [NSString stringWithFormat:@"%@ to %@", firstDateStringFormatted,lastDateStringFormatted];
    }else{
        NSString *fisrtDateString = arrayOfDates[0];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        NSDate *firstDate = [dateFormatter dateFromString:fisrtDateString];
        NSString *firstDateStringFormatted = [dateFormatter stringFromDate:firstDate];
        fullDate = [NSString stringWithFormat:@"%@", firstDateStringFormatted];
    }
    
  
    
   
    
    
    
    UILabel * datesLabel = (UILabel *)[cell viewWithTag:2];
    datesLabel.text = fullDate;
    
    
    
    //    pnumber
    UILabel * pnumberLabel = (UILabel *)[cell viewWithTag:3];
    pnumberLabel.text = [[_events objectAtIndex:indexPath.row] valueForKey:@"p_number"];
    
  
    
    //    cell.textLabel.text =  [ [self.attendees objectAtIndex:indexPath.row] valueForKey:@"firstName" ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80; // your dynamic height...
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    self.event_id = [[_events objectAtIndex:indexPath.row] valueForKey:@"id"];
    
    
    if( [self.userRole isEqualToString:@"Event Manager"] ){
        [self performSegueWithIdentifier:@"eventEventMangaerSegue" sender:self];
    }
    
    if( [self.userRole isEqualToString:@"Equipment Manager"] ){
        [self performSegueWithIdentifier:@"eventEquipmentMangaerSegue" sender:self];
    }
    
    
   
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"eventEventMangaerSegue"]) {
        EventManagerEventViewController *destViewController = segue.destinationViewController;
        destViewController.event_id = self.event_id;
    }
    
    
    if ([segue.identifier isEqualToString:@"eventEquipmentMangaerSegue"]) {
        EquipmentManagerEventViewController *destViewController = segue.destinationViewController;
        destViewController.event_id = self.event_id;
    }
    
    
}





@end
