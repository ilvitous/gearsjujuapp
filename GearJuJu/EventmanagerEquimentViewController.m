//
//  EventmanagerEquimentViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/19/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "EventmanagerEquimentViewController.h"

@interface EventmanagerEquimentViewController ()
@property (nonatomic,strong) NSMutableArray *equipment;

@end

@implementation EventmanagerEquimentViewController
@synthesize equipmentTableView;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.equipmentTableView.delegate = self;
    self.equipmentTableView.dataSource = self;
    self.equipmentTableView.backgroundColor = [UIColor clearColor];
    
    [self get_all_equipment];
    
}

-(void)get_all_equipment{
    
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/equipment/all"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"GET";
    
    [request setValue:bearer forHTTPHeaderField:@"Authorization"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    
    NSURLSessionDataTask *uploadTask = [session dataTaskWithRequest:request
                                                  completionHandler:^(NSData *data,NSURLResponse *response,NSError *error) {
                                                      
                                                      id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                      
                                                      NSString *status = [jsonOutput valueForKey:@"status"];
                                                      
                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                          
                                                          if ([[NSThread currentThread] isMainThread]){
                                                              NSLog(@"In main thread--completion handler");
                                                              
                                                              if( [status isEqualToString:@"success"]  ){
                                                                  self.equipment = [jsonOutput valueForKey:@"data"];
                                                                  [self.equipmentTableView reloadData];
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
    UITableViewCell *cell = [self.equipmentTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *eqipmentArray = [[self.equipment objectAtIndex:indexPath.section] valueForKey:@"equipments"];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:1];
    nameLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    
    //assigned to
    UILabel *assignedLabel = (UILabel *)[cell viewWithTag:3];
    assignedLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"user"];
    
     UILabel *consignedLabel = (UILabel *)[cell viewWithTag:4];
    
     if( ![ [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"consigned"]  isEqual:[NSNull null]] ){
         consignedLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"consigned"];
     }else{
         consignedLabel.text = [NSString stringWithFormat:@""];
     }
   
    
    
    UILabel *eventLabel = (UILabel *)[cell viewWithTag:2];
    eventLabel.text = [[ eqipmentArray objectAtIndex:indexPath.row] valueForKey:@"gearevent_title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100; // your dynamic height...
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
