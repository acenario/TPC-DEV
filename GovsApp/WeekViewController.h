//
//  WeekViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>
#import "SearchResult.h"
#import "SVProgressHUD.h"


@interface WeekViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end

