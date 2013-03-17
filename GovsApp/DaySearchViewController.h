//
//  DaySearchViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>
#import "SearchResult.h"

@interface DaySearchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end
