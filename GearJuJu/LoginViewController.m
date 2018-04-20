//
//  LoginViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()


@end

@implementation LoginViewController

@synthesize alert;
@synthesize email;
@synthesize password;
@synthesize EmailTextField;
@synthesize PasswordTextField;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.EmailTextField.delegate = self;
    self.PasswordTextField.delegate = self;
    
    self.EmailTextField.tag = 100;
    self.PasswordTextField.tag = 101;
    
    
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
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




// pragma mark is used for easy access of code in Xcode
#pragma mark - TextField Delegates


// This method is called once we click inside the textField
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.EmailTextField endEditing:YES];
    [self.PasswordTextField endEditing:YES];
    
   
    
}

// This method is called once we complete editing
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
    if(textField.tag == 100){
        self.email = textField.text;
    }
    
    if(textField.tag == 101){
        self.password = textField.text;
    }
    
    NSLog(@"Text: %@",textField.text);
    
    NSLog(@"Email: %@ - Password: %@", self.email, self.password);
}

// This method enables or disables the processing of return key
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if(textField.tag == 100){
        self.email = textField.text;
    }
    
    if(textField.tag == 101){
        self.password = textField.text;
    }
    NSLog(@"Text: %@",textField.text);
    NSLog(@"Email: %@ - Password: %@", self.email, self.password);
    
    [textField resignFirstResponder];
    return YES;
}



//actions

- (IBAction)openPreferences:(id)sender {
    
    
    self.alert = [[UIAlertController alloc]init];
    
    
    self.alert = [UIAlertController alertControllerWithTitle:@"Protected Area"
                                                     message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
    [self.alert addTextFieldWithConfigurationHandler:^(UITextField *textField) { textField.keyboardType = UIKeyboardTypeAlphabet; }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Insert Password"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         
                                                         UITextField *textField = [alert.textFields firstObject];
                                                         NSString *passWord = textField.text;
                                                         
                                                         if([passWord isEqual:@"1lovejuju"]){
                                                             [self performSegueWithIdentifier:@"adminSegue" sender:self];
                                                            
                                                             
                                                         }else{
                                                             [self dismissViewControllerAnimated:YES completion:nil];
                                                         }
                                                         
                                                         
                                                     }];
    [self.alert addAction:okAction];
    
    [self presentViewController:self.alert animated:YES completion:nil];
    
    [self.alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
}



//login

- (IBAction)login:(id)sender {
    
    self.password =  @"antani73";
    self.email = @"mandym@pridegroup.us";
    
    
    if(self.password && self.email){
        
        
        NSURL *url = [NSURL URLWithString:@"http://laravel.roar.design/api/auth/login"];
        // 2
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        // 3
        NSDictionary *dictionary = @{@"email": @"Equipment@PrideGroup.us", @"password": @"antani73"};
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions error:&error];
        
        
        
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
                                                                                 
//                                                                               WE ARE LOGGED DO SOEMTHING COOL!
                                                                                 if( [status isEqualToString:@"success"]  ){
                                                                                     
                                                                                     if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                                                                                         NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
                                                                                         NSDictionary *headers = [httpResponse allHeaderFields];
                                                                                         [[NSUserDefaults standardUserDefaults] setObject:[headers valueForKey:@"Authorization"] forKey:@"Bearer"];
                                                                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                                                                         [self performSegueWithIdentifier:@"homeSegue" sender:self];
                                                                                         
                                                                                     }
                                                                                     
                                                                                     
                                                                                     
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
            
            
            // 5
            [uploadTask resume];
            
            
            
            
        }
        
    }else{
        
        
        NSLog(@"Password: %@ - Email: %@",self.password, self.email);

    
    }
    
}




@end
