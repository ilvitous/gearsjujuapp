//
//  HomeViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize bearer;
@synthesize userName;
@synthesize userRole;
@synthesize RoleLabel;
@synthesize UsernameLabel;
@synthesize EventManagerView;
@synthesize EquipmentManagerView;

@synthesize action;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *bearer = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    self.bearer = [NSString stringWithFormat:@"Bearer %@", bearer];
    
//    setup the home for user role
    self.UsernameLabel.text = @"";
    self.RoleLabel.text = @"";
    self.EventManagerView.hidden = true;
    self.EquipmentManagerView.hidden = true;
    
    
    
    
    [self getLoggedUser];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)getLoggedUser{
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/get-user"];
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
                                                                  
                                                               NSDictionary *user = [jsonOutput valueForKey:@"data"];
                                                               NSDictionary *role = [user valueForKey:@"role"];
                                                               
                                                               self.userName = [user valueForKey:@"name"];
                                                               self.userRole = [role valueForKey:@"name"];
                                                               
                                                                  
                                                                  self.UsernameLabel.text = self.userName;
                                                                  self.RoleLabel.text = self.userRole;
                                                                  
                                                                  [[NSUserDefaults standardUserDefaults] setObject:self.userRole forKey:@"UserRole"];
                                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                                  
                                                                  
                                                                  [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"UserName"];
                                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                                  
                                                                  [[NSUserDefaults standardUserDefaults] setObject:[user valueForKey:@"id"] forKey:@"UserId"];
                                                                  [[NSUserDefaults standardUserDefaults] synchronize];
                                                                  
                                                                  
                                                                  [self setRoleView];
                                                                  
                                                                  
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


-(void)setRoleView{
    
    if( [self.userRole isEqualToString:@"Event Manager"] ){
        self.EventManagerView.hidden = false;
    }
    
    if( [self.userRole isEqualToString:@"Equipment Manager"] ){
        self.EquipmentManagerView.hidden = false;
    }
    
    
}


//button action

- (IBAction)LogOut:(id)sender {
    
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/auth/logout"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
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
                                                                  
                                                                [[self navigationController] popToRootViewControllerAnimated:YES];
                                                                  
                                                                  
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

- (IBAction)GoToEvents:(id)sender {
     [self performSegueWithIdentifier:@"eventsSegue" sender:self];
}


- (IBAction)GoToEquimpent:(id)sender {
    [self performSegueWithIdentifier:@"euipmentManagerEquipmentSegue" sender:self];
}


- (IBAction)OpenScannerModal:(id)sender {
    self.action = [NSString stringWithFormat:@"checkin"];
    [self performSegueWithIdentifier:@"modalScannerSegue" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    if ([segue.identifier isEqualToString:@"modalScannerSegue"]) {
        ScannerViewController *destViewController = segue.destinationViewController;
        destViewController.action = self.action;
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
