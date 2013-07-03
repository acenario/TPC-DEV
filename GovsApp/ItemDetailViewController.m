//
//  ItemDetailViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/29/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "PlannerItem.h"
#import "ItemDetailViewController.h"
#import <Scringo/ScringoAgent.h>

@interface ItemDetailViewController ()

@end

@implementation ItemDetailViewController {
    NSDate *dueDate;
}

@synthesize delegate, itemToEdit, priorityValue, priorityLevel;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.textField becomeFirstResponder];
}

- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScringoAgent pauseSwipe];
    
    if (self.itemToEdit != nil) {
        self.title = @"Edit Item";
        self.textField.text = self.itemToEdit.text;
        self.priorityLevel.selectedSegmentIndex = self.itemToEdit.priority;
        self.doneBarButton.enabled = YES;
        self.switchControl.on = self.itemToEdit.shouldRemind;
        dueDate = self.itemToEdit.dueDate;
    } else {
        self.switchControl.on = NO;
        dueDate = [NSDate date];
    }
    
    [self updateDueDateLabel];
    
    priorityLevel.selectedFont = [UIFont boldFlatFontOfSize:14];
    priorityLevel.selectedFontColor = [UIColor cloudsColor];
    priorityLevel.deselectedFont = [UIFont flatFontOfSize:14];
    priorityLevel.deselectedFontColor = [UIColor cloudsColor];
    priorityLevel.selectedColor = [UIColor belizeHoleColor];
    priorityLevel.deselectedColor = [UIColor peterRiverColor];
    priorityLevel.dividerColor = [UIColor wetAsphaltColor];
    priorityLevel.cornerRadius = 15.0;
    
    //NSLog(@"Priority Value: %d", self.priorityValue);
    //NSLog(@"Priority Index: %d", self.priorityLevel.selectedSegmentIndex);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)segmentUpdated:(id)sender {
    
    switch (self.priorityLevel.selectedSegmentIndex) {
        case 0:
            priorityValue = priorityLevel.selectedSegmentIndex;
            break;
        case 1:
            priorityValue = priorityLevel.selectedSegmentIndex;
            break;
        case 2:
            priorityValue = priorityLevel.selectedSegmentIndex;
            break;
        default:
            break;
    }
    
}

- (IBAction)cancel
{
    [self.delegate itemDetailViewControllerDidCancel:self];
}
- (IBAction)done
{
    if (self.itemToEdit == nil) {
    PlannerItem *item = [[PlannerItem alloc] init];
    item.text = self.textField.text;
    item.checked = NO;
    item.priority = self.priorityValue;
    item.shouldRemind = self.switchControl.on;
    item.dueDate = dueDate;
    
    [item scheduleNotification];    
        
    [self.delegate itemDetailViewController:self didFinishAddingItem:item];
    } else {
        self.itemToEdit.text = self.textField.text;
        self.itemToEdit.priority = self.priorityValue;
        self.itemToEdit.shouldRemind = self.switchControl.on;
        self.itemToEdit.dueDate = dueDate;
        
        [self.itemToEdit scheduleNotification];
        
        [self.delegate itemDetailViewController:self didFinishEditingItem:self.itemToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return indexPath;
    } else {
        return nil;
    }
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newText length] > 0);
    
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PickDate"]) {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}

- (void)datePickerDidCancel:(DatePickerViewController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)datePicker:(DatePickerViewController *)picker didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
