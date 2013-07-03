//
//  MonthViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>
#import "SearchResult.h"
#import "SVProgressHUD.h"


@interface MonthViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) EKEventStore *eventStore;


- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end
