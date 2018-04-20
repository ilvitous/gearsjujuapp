//
//  ScannerViewController.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/20/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScannerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *popUp;
@property (weak, nonatomic) IBOutlet UIButton *DismissButton;

@property (strong, nonatomic) NSString *action;

@end
