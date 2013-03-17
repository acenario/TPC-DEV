//
//  WeekViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UnderRightViewController.h"
//#import "TableSection.h"

@interface WeekViewController : PFQueryTableViewController

- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;


@property (nonatomic, retain) NSArray* tableSections;

@end
