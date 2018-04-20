//
//  AddNewEventViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/18/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "AddNewEventViewController.h"

@interface AddNewEventViewController ()

@end

@implementation AddNewEventViewController

@synthesize EventNameTextField;
@synthesize PnumberTextField;
@synthesize AddressTextField;
@synthesize DateStartTextField;
@synthesize DateEndTextField;
@synthesize StartDate;
@synthesize EndDate;

@synthesize EventName;
@synthesize Address;
@synthesize PNumber;




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.EventNameTextField.delegate = self;
    self.EventNameTextField.tag = 100;
    
    self.PnumberTextField.delegate = self;
    self.PnumberTextField.tag = 101;
    
    self.AddressTextField.delegate = self;
    self.AddressTextField.tag = 102;
    
    self.DateStartTextField.delegate = self;
    self.DateStartTextField.tag = 103;
    
    self.DateEndTextField.delegate = self;
    self.DateEndTextField.tag = 104;
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    
    UIDatePicker *datePickerEnd = [[UIDatePicker alloc]init];
    datePickerEnd.datePickerMode = UIDatePickerModeDate;
    [datePickerEnd setDate:[NSDate date]];
    [datePickerEnd addTarget:self action:@selector(updateTextFieldEnd:) forControlEvents:UIControlEventValueChanged];
    
    
    
    [self.DateStartTextField setInputView:datePicker];
    [self.DateEndTextField setInputView:datePickerEnd];
    
    
}



#pragma mark - keyboard movements

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    
    if(textField.tag == 102){
        self.Address = textField.text;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -200;
            self.view.frame = f;
        }];
    }
    
   
    
    
    return YES;
}


//date picker
-(void)updateTextFieldEnd:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.DateEndTextField.inputView;
    self.DateEndTextField.text = [self formatDate:picker.date];
    self.EndDate = [self formatDate:picker.date];
}


-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.DateStartTextField.inputView;
    self.DateStartTextField.text = [self formatDate:picker.date];
    self.StartDate = [self formatDate:picker.date];
}


// Formats the date chosen with the date picker.
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"MM'/'dd'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

//date picker

//textfield delegate

// pragma mark is used for easy access of code in Xcode
#pragma mark - TextField Delegates


// This method is called once we click inside the textField
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.EventNameTextField endEditing:YES];
    [self.PnumberTextField endEditing:YES];
    [self.AddressTextField endEditing:YES];
    [self.DateStartTextField endEditing:YES];
    [self.DateEndTextField endEditing:YES];
}




// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if(textField.tag == 100){
        self.EventName = textField.text;
    }
    
    if(textField.tag == 101){
        self.PNumber = textField.text;
    }
    
    if(textField.tag == 102){
        self.Address = textField.text;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = 0;
            self.view.frame = f;
        }];
        
    }
    
   
    
    
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField.tag == 100){
        self.EventName = textField.text;
    }
    
    if(textField.tag == 101){
        self.PNumber = textField.text;
    }
    
    if(textField.tag == 102){
        self.Address = textField.text;
        
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = 0;
            self.view.frame = f;
        }];
    }
    
    [textField resignFirstResponder];
    
    
    
    
    return YES;
}






//actions

- (IBAction)closeModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addEvent:(id)sender {
    
//    format the date
    NSString *startDateStringFormatted = @"";
    NSString *endDateStringFormatted = @"";
    
    NSMutableArray *datesArray = [[ NSMutableArray alloc] init];
    
    
    if(self.StartDate){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *startDate = [dateFormatter dateFromString:self.StartDate];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        startDateStringFormatted = [dateFormatter stringFromDate:startDate];
        NSLog(@"%@",startDateStringFormatted);
        [datesArray addObject: startDateStringFormatted ];
    }
    
    if(self.EndDate){
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
        NSDate *endDate = [dateFormatter dateFromString:self.EndDate];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
        endDateStringFormatted = [dateFormatter stringFromDate:endDate];
        NSLog(@"%@",endDateStringFormatted);
        [datesArray addObject: endDateStringFormatted ];
    }
    
    if(self.EventName && self.Address && self.PNumber && self.StartDate){
        
        NSString *auth = [[NSUserDefaults standardUserDefaults] objectForKey:@"Bearer"];
        NSString *bearer = [NSString stringWithFormat:@"Bearer %@", auth];
        
        NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/v1/events/add"];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:bearer forHTTPHeaderField:@"Authorization"];
        NSDictionary *dictionary = @{@"title": self.EventName, @"address": self.Address, @"p_number" : self.PNumber, @"dates": datesArray};
        
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
                             NSLog(@"Status: %@",status);
                            [self dismissViewControllerAnimated:YES completion:nil];
                            
                            
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
