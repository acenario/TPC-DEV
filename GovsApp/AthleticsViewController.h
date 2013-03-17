//
//  SecondViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AthleticsViewController : UITableViewController

@property (strong, nonatomic) UIButton *govBtn;

- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end
