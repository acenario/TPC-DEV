//
//  ListDetailViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

@class ListDetailViewController;
@class Planner;


@protocol ListDetailViewControllerDelegate <NSObject>

- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingPlanner:(Planner *)planner;

- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingPlanner:(Planner *)planner;

@end

@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITextField *textField;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Planner *plannerToEdit;
@property (nonatomic, strong) IBOutlet UIImageView *iconImageView;


- (IBAction)cancel;
- (IBAction)done;

@end
