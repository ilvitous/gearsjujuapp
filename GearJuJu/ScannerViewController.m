//
//  ScannerViewController.m
//  GearJuJu
//
//  Created by Andrea Vitale on 4/20/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import "ScannerViewController.h"

@interface ScannerViewController ()

@end

@implementation ScannerViewController
@synthesize popUp;
@synthesize DismissButton;
@synthesize action;


//action
//checkin



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.popUp.layer.cornerRadius = 5;
    self.popUp.layer.masksToBounds = true;
    self.DismissButton.layer.cornerRadius = 5;
    self.DismissButton.layer.masksToBounds = true;
}


- (IBAction)CloseScannerModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
