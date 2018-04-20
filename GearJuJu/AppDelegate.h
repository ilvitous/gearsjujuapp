//
//  AppDelegate.h
//  GearJuJu
//
//  Created by Andrea Vitale on 4/16/18.
//  Copyright © 2018 Pride Group LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Captuvo.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CaptuvoEventsProtocol>

@property (strong, nonatomic) UIWindow *window;


@end

