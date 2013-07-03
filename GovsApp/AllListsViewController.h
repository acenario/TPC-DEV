//
//  AllListsViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"
#import "PlannerViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

-(IBAction)goBack;
//-(void)savePlanners;

@end
