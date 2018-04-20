//
//  ScannerViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/20/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "ScannerViewController.h"
#import "Captuvo+PrivateAPI.h"

@interface ScannerViewController ()
@property (weak, nonatomic) UIDevice *device;
@property (assign,nonatomic)BOOL updating;

@property (nonatomic,strong) NSMutableArray *apiResponse;

@end

@implementation ScannerViewController
@synthesize popUp;
@synthesize DismissButton;
@synthesize action;
@synthesize actionLabel;
@synthesize readyLabel;
@synthesize responseLabel;
@synthesize response;


//checkin
@synthesize checkinResponseView;
@synthesize checkinEventNameLabel;
@synthesize checkinAssociateNameLabel;
@synthesize checkinFieldNameLabel;


//error
@synthesize errorLabel;
@synthesize status;


//assign
@synthesize event;
@synthesize equipment_request;
@synthesize gear_request;

@synthesize assignResponseView;
@synthesize deviceNameLabel;
@synthesize successLabel;
@synthesize requesterID;


//consign
@synthesize consignResponseView;
@synthesize abiLabel;
@synthesize equipmentIdLabel;
@synthesize equipmentNameLabel;
@synthesize abiNumber;
@synthesize successConsignLabel;




//action
//checkin



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popUp.layer.cornerRadius = 5;
    self.popUp.layer.masksToBounds = true;
    self.DismissButton.layer.cornerRadius = 5;
    self.DismissButton.layer.masksToBounds = true;
    
    self.errorLabel.hidden = true;
    
    
    //    powercontrol
    self.updating = NO;
    self.device = [UIDevice currentDevice];
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    
    
//    checkin response
    self.checkinResponseView.hidden = true;
    
//    assign response
    self.assignResponseView.hidden = true;
    
//    consign response
    self.consignResponseView.hidden = true;
    
    
    if( [self.action isEqualToString:@"checkin" ] ){
        self.actionLabel.text = [NSString stringWithFormat:@"CHECK IN"];
    }
    
    if( [self.action isEqualToString:@"assign" ] ){
        self.actionLabel.text = [NSString stringWithFormat:@"ASSIGN"];
       
    }
    
    
    if( [self.action isEqualToString:@"consign" ] ){
        self.actionLabel.text = [NSString stringWithFormat:@"CONSIGN"];
        
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[Captuvo sharedCaptuvoDevice] addCaptuvoDelegate:self];
    [[Captuvo sharedCaptuvoDevice] startDecoderHardware];
    [[Captuvo sharedCaptuvoDevice] startPMHardware];
    NSLog(@"Event: %@", self.event);
    NSLog(@"Equipment Request: %@", self.equipment_request);
    NSLog(@"Gear Request: %@", self.gear_request);
    NSLog(@"Requester: %@", self.requesterID);
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[Captuvo sharedCaptuvoDevice] removeCaptuvoDelegate:self];
    [[Captuvo sharedCaptuvoDevice] stopDecoderHardware];
    [[Captuvo sharedCaptuvoDevice] stopPMHardware];
}


- (IBAction)CloseScannerModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Captuvo Delegate
- (void)decoderReady
{
    self.readyLabel.hidden = false;
    
    
}



-(void)captuvoConnected{
    [[Captuvo sharedCaptuvoDevice] startDecoderHardware];
}


-(void)captuvoDisconnected{
    [[Captuvo sharedCaptuvoDevice] stopDecoderHardware];
   
}


-(void)decoderDataReceived:(NSString *)data{
    NSLog(@"Decoder Data Received: %@",data);
    
    self.response = [NSString stringWithFormat:@"%@",data];
    
//    debug
    self.responseLabel.text = self.response;
    
    
    
//    response view reset
    self.errorLabel.hidden = true;
    self.checkinEventNameLabel.text = nil;
    self.checkinAssociateNameLabel.text = nil;
    self.checkinFieldNameLabel.text = nil;
    self.checkinResponseView.hidden = true;
    self.assignResponseView.hidden = true;
    self.deviceNameLabel.text = nil;
    self.consignResponseView.hidden = true;
    self.abiLabel.text = nil;
    self.equipmentIdLabel.text = nil;
    self.equipmentNameLabel.text = nil;
    self.successConsignLabel.hidden = true;

    
    
    
    
//    call actions
    if( [self.action isEqualToString:@"checkin"] ){
        [self check_in];
    }
    
    
    if( [self.action isEqualToString:@"assign"] ){
        [self assign];
    }
    
    if( [self.action isEqualToString:@"consign"] ){
        [self consign];
    }
    
}

-(void)consign{
    
//    check if is ABI
    self.consignResponseView.hidden = false;
    
    if( [self.response length] > 4 ){
       
        self.abiNumber = self.response;
    }else{
        
        self.equipment_id = self.response;
    }
     self.abiLabel.text = self.abiNumber;
     self.equipmentIdLabel.text = self.equipment_id;
    
    
    if(self.equipment_id && self.abiNumber){
        
//        parameter
//        'event_id' => 'required',
//        'id' => 'required',
//        'assigned_to' => 'required',
//
        
        NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
        NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/equipment/consign"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:bearer forHTTPHeaderField:@"Authorization"];
        
        NSDictionary *dictionary = @{@"id": self.equipment_id , @"assigned_to" : self.abiNumber , @"event_id" : self.event};
        
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
        NSURLSession *session = [NSURLSession sharedSession];
        
        if (!error) {
            // 4
            NSURLSessionDataTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
                id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSString *status = [jsonOutput valueForKey:@"status"];
                self.status = status;
                NSString *msg = [jsonOutput valueForKey:@"msg"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[NSThread currentThread] isMainThread]){
                        NSLog(@"In main thread--completion handler");
                        //
                        if( [status isEqualToString:@"success"]  ){
                            
                            self.apiResponse = [[NSMutableArray alloc] init];
                            self.apiResponse = [jsonOutput valueForKey:@"data"];
                            [self consign_response];
                            
                            
                            
                        }else{
                            NSLog(@"Status: %@",status);
                            NSLog(@"Message: %@",msg);
                            self.apiResponse = [[NSMutableArray alloc] init];
                            self.apiResponse = [jsonOutput valueForKey:@"data"];
                           [self consign_response];
                            
                        }
                        
                    }
                    else{
                        NSLog(@"Not in main thread--completion handler");
                    }
                });
                
                
            }];
            [uploadTask resume];
        }
        
//        reset
        self.abiNumber = nil;
        self.equipment_id = nil;
        
    }
    
}

-(void)consign_response{
    NSString *errorMessage  = [self.apiResponse valueForKey:@"message"];
    
    if( [ self.status isEqualToString:@"success" ] ){
        
        self.equipmentNameLabel.text = [self.apiResponse valueForKey:@"name"];
        self.successConsignLabel.hidden = false;
        
        
    }else{
        self.errorLabel.text = errorMessage;
        self.errorLabel.hidden = false;
    }
}


-(void)assign{
    // string id is correct - let's check in
    
//    parameters
    // 'event' => 'required',
    // 'equipment_id' => 'required',
    // 'user' => 'required',
    // 'equipment_request' => 'required',
    // 'gear_request' => 'required',
    
   
    
    NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
    NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
    
    NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/equipment/assign"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:bearer forHTTPHeaderField:@"Authorization"];
    
    NSDictionary *dictionary = @{@"event": self.event , @"equipment_id" : self.response , @"user" : self.requesterID , @"equipment_request" : self.equipment_request , @"gear_request" : self.gear_request};
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
    NSURLSession *session = [NSURLSession sharedSession];
    
    if (!error) {
        // 4
        NSURLSessionDataTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
            id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            NSString *status = [jsonOutput valueForKey:@"status"];
            self.status = status;
            NSString *msg = [jsonOutput valueForKey:@"msg"];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[NSThread currentThread] isMainThread]){
                    NSLog(@"In main thread--completion handler");
                    //
                    if( [status isEqualToString:@"success"]  ){
                        
                        self.apiResponse = [[NSMutableArray alloc] init];
                        self.apiResponse = [jsonOutput valueForKey:@"data"];
                        [self assign_response];
                        
                        
                        
                    }else{
                        NSLog(@"Status: %@",status);
                        NSLog(@"Message: %@",msg);
                        self.apiResponse = [[NSMutableArray alloc] init];
                        self.apiResponse = [jsonOutput valueForKey:@"data"];
                        [self check_in_response];
                        
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
-(void)assign_response{
    
    
    NSString *errorMessage  = [self.apiResponse valueForKey:@"message"];
    
    if( [ self.status isEqualToString:@"success" ] ){
        
        self.assignResponseView.hidden = false;
        self.deviceNameLabel.text = [NSString stringWithFormat:@"%@", [self.apiResponse valueForKey:@"name"] ];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"AssignSuccess"
         object:nil userInfo:nil];
        
        
        
    }else{
        self.errorLabel.text = errorMessage;
        self.errorLabel.hidden = false;
    }

    
    
}

-(void)check_in{
    
//    check if the id is correct
    
    
    
   
    
        // string id is correct - let's check in
        NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
        
        NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/equipment/unassign"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:bearer forHTTPHeaderField:@"Authorization"];
        
        NSDictionary *dictionary = @{@"equipment_id": self.response};
        
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary options:kNilOptions error:&error];
        NSURLSession *session = [NSURLSession sharedSession];
        
        if (!error) {
            // 4
            NSURLSessionDataTask *uploadTask = [session uploadTaskWithRequest:request fromData:data completionHandler:^(NSData *data, NSURLResponse *response,NSError *error) {
                id jsonOutput = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                
                NSString *status = [jsonOutput valueForKey:@"status"];
                self.status = status;
                NSString *msg = [jsonOutput valueForKey:@"msg"];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[NSThread currentThread] isMainThread]){
                        NSLog(@"In main thread--completion handler");
                        //
                        if( [status isEqualToString:@"success"]  ){
                            
                            self.apiResponse = [[NSMutableArray alloc] init];
                            self.apiResponse = [jsonOutput valueForKey:@"data"];
                            
                            [self check_in_response];
                            
                            
                            
                        }else{
                            NSLog(@"Status: %@",status);
                            NSLog(@"Message: %@",msg);
                            self.apiResponse = [[NSMutableArray alloc] init];
                            self.apiResponse = [jsonOutput valueForKey:@"data"];
                            [self check_in_response];
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

-(void) check_in_response{
    
    NSString *errorMessage  = [self.apiResponse valueForKey:@"message"];
    if( [ self.status isEqualToString:@"success" ] ){
        self.checkinEventNameLabel.text = [NSString stringWithFormat:@"%@", [self.apiResponse valueForKey:@"gearevent_name"] ];
        self.checkinAssociateNameLabel.text = [NSString stringWithFormat:@"%@", [self.apiResponse valueForKey:@"user"] ];
        self.checkinFieldNameLabel.text = [NSString stringWithFormat:@"%@", [self.apiResponse valueForKey:@"assigned_to"] ];
        self.checkinResponseView.hidden = false;
    }else{
        self.errorLabel.text = errorMessage;
        self.errorLabel.hidden = false;
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
