//
//  PreferencesViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/17/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "PreferencesViewController.h"

@interface PreferencesViewController ()

@end

@implementation PreferencesViewController
@synthesize apiUrlTextField;
@synthesize apiUrl;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    
//    api url text field init
    self.apiUrlTextField.delegate = self;
    self.apiUrlTextField.tag = 100;
    
    NSString *apiUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiUrl"];
    
    NSLog(@"url: %@", apiUrl);
    
    if(apiUrl){
        self.apiUrlTextField.text = apiUrl;
    }
    
    
}


//textfield delegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
    
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    if(textField.tag == 100)
    {
        self.apiUrl = textField.text;
        
    }
    
    [self savePreferences];
    
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    if(textField.tag == 100)
    {
        self.apiUrl = textField.text;
        
    }
    
    [textField resignFirstResponder];
    [self savePreferences];
    
    return YES;
}


-(void)savePreferences {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.apiUrl forKey:@"apiUrl"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
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



//actions

- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
