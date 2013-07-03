//
//  PlannerViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/25/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"
#import "Planner.h"



@interface PlannerViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Planner *planner;





@end
