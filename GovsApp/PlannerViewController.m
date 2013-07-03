//
//  PlannerViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/25/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "PlannerViewController.h"
#import "PlannerItem.h"
#import <Scringo/ScringoAgent.h>

@interface PlannerViewController ()

@end

@implementation PlannerViewController 

@synthesize planner;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [ScringoAgent pauseSwipe];
    
    
    //Code for Red Bar
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
	// Do any additional setup after loading the view.
    
    self.title = self.planner.name;
    
        
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self becomeFirstResponder];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlert {
    
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"Tip!"
                                                          message:@"Shake to delete checked Items!"
                                                         delegate:nil cancelButtonTitle:@"Okay"
                                                otherButtonTitles:nil];
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:14];
    alertView.backgroundOverlay.backgroundColor = [UIColor clearColor];
    alertView.alertContainer.backgroundColor = [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0];
    alertView.defaultButtonColor = [UIColor cloudsColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor asbestosColor];
    
    
    [alertView show];
}


- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    if ( event.subtype == UIEventSubtypeMotionShake )
    {
        
        int i = 0;
       while (i < [self.planner.items count]) {
            PlannerItem *item = [self.planner.items objectAtIndex:i];
            
            if (item.checked) {
                
                [self.planner.items removeObject:item];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
                [self.tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                
            } else {
                i++;
            }
            
            [SVProgressHUD showSuccessWithStatus:@"Cleared!"];
        }
        
            
    }
    
    if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
        [super motionEnded:motion withEvent:event];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;

}

- (void)configureCheckmarkForCell:(UITableViewCell *)cell withPlannerItem:(PlannerItem *)item
{
    UIFont *myFont = [UIFont flatFontOfSize:22];
    UIColor *myColor = [UIColor peterRiverColor];

    UILabel *label = (UILabel *)[cell viewWithTag:1001];
    
    
    label.font = myFont;
    label.textColor = myColor;
    
    if (item.checked) {
        //cell.accessoryType = UITableViewCellAccessoryCheckmark;
        label.text = @"√";
        
        BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"Shake"];
        if(firstTime) {
            [self showAlert];
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"Shake"];
        }
        
    } else {
        //cell.accessoryType = UITableViewCellAccessoryNone;
        label.text = @"";
    }
}

- (void)configureTextForCell:(UITableViewCell *)cell withPlannerItem:(PlannerItem *)item
{
    UIFont *myFont = [UIFont flatFontOfSize:18];
    UIFont *dateFont = [UIFont flatFontOfSize:16];
    UIColor *myColor = [UIColor midnightBlueColor];
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:1003];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    int value = item.priority;
    
    if (value == 0) {
        label.textColor = myColor;
    } else if (value == 1) {
        label.textColor = [UIColor orangeColor];
    } else if (value == 2) {
        label.textColor = [UIColor pomegranateColor];
    }
    
    label.font = myFont;
    dateLabel.font = dateFont;
    dateLabel.textColor = [UIColor silverColor];
    label.text = item.text;
    dateLabel.text = [formatter stringFromDate:item.dueDate];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.itemToEdit = sender;
    }
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.planner.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryItem"];
    
    
    PlannerItem *item = [self.planner.items objectAtIndex:indexPath.row];
    
    
    [self configureTextForCell:cell withPlannerItem:item];
    [self configureCheckmarkForCell:cell withPlannerItem:item];
    
    
    
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    PlannerItem *item = [self.planner.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    
    [self configureCheckmarkForCell:cell withPlannerItem:item];
    
    //[self.delegate savePlanner];
    //[self.dataModel savePlanners];
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*-(IBAction)addItem
{
    
    int newRowIndex = [items count];
    
    PlannerItem *item = [[PlannerItem alloc] init];
    
    item.text = @"I am a new row";
    item.checked = NO;
    [items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}*/



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.planner.items removeObjectAtIndex:indexPath.row];
    
    //[self.delegate savePlanner];
    //[self.dataModel savePlanners];
    
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    indexPaths = [NSArray arrayWithObject:indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)itemDetailViewControllerDidCancel:(ItemDetailViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishAddingItem:(PlannerItem *)item
{
    int newRowIndex = [self.planner.items count];
    [self.planner.items addObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self sortPlannerItems];
    [self.tableView reloadData];
    
    //[self.delegate savePlanner];
    //[self.dataModel savePlanners];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailViewController:(ItemDetailViewController *)controller didFinishEditingItem:(PlannerItem *)item
{
    int index = [self.planner.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withPlannerItem:item];
    
    [self sortPlannerItems];
    [self.tableView reloadData];
    
    //[self.delegate savePlanner];
    //[self.dataModel savePlanners];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    PlannerItem *item = [self.planner.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}

- (void)sortPlannerItems
{
    [self.planner.items sortUsingSelector:@selector(compare:)];
}



@end
