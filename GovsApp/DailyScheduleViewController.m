//
//  DailyScheduleViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 6/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//https://api.gda:phevarE3r@api.veracross.com/gda/v1/enrollments.json?student=%@

#import "DailyScheduleViewController.h"
#import "ScheduleResultCell.h"
#import "JSONModelLib.h"
#import "ClassFeed.h"

static NSString *const SearchResultCellIdentifier = @"SearchResultCell";
static NSString *const NothingFoundCellIdentifier = @"NothingFoundCell";



@interface DailyScheduleViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;


@end

@implementation DailyScheduleViewController {
    NSMutableArray *searchResults;
    NSMutableArray *contentArray;
    NSString *sendClassfk;
    
    
}

@synthesize tableView = _tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:
            @"Milestone.plist"];
    
}


- (void) hideKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    contentArray = [NSArray arrayWithContentsOfFile:[self dataFilePath]];
    
    
    
    self.tableView.rowHeight = 80;
	
    UINib *cellNib = [UINib nibWithNibName:@"ScheduleResultCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:
     NothingFoundCellIdentifier];
    
    [self pullData];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    //[SVProgressHUD dismiss];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Sidebar Button Code
- (IBAction)searchBtn:(id)sender {
    
    [ScringoAgent openSidebar];
    
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}


#pragma mark - Segue Editing

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"editClass"])
    {
        EditClassViewController *controller = [segue destinationViewController];
        
        
        controller.delegate = self;
        
        controller.idValue = sendClassfk;
        //NSLog(@"sending value numero dos: %@", controller.idValue);
        
    }
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (searchResults == nil) {
        return 0;
    } else if ([searchResults count] == 0) {
        return 1;
    } else {
        return [searchResults count];
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:
                NothingFoundCellIdentifier];
        
        
        
    } else {
        
        ScheduleResultCell *cell = (ScheduleResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
        
        ScheduleResult *searchResult = [searchResults objectAtIndex:indexPath.row];
        
            
        NSString *classFormat = @"%@";
        NSString *classfks = searchResult.class_fk;
        NSString *classfk = [NSString stringWithFormat:classFormat, classfks];
       
        
    
        /*NSString *place = [self placeForDisplay:searchResult.place];
        if (place == (NSString *)[NSNull null]) {
            place = @"Not provided";
        }*/
        
        /*NSString *timeValue = searchResult.time;
        
        if (timeValue == (NSString *)[NSNull null]) {
            timeValue = nil;
        }*/
        
        //NSString *timeConverted = [self userVisibleDateTimeStringForRFC3339DateTimeString:timeValue];
        
        
        //NSString *dateValue = searchResult.startDate;
        
        //NSString *dateConverted = [self userVisibleDateStringForDateString:dateValue];
        
        cell.blockLabel.text = searchResult.block;
        cell.nameLabel.text = searchResult.name;
        cell.idLabel.text = classfk;
        cell.teacherLabel.text = searchResult.teacher;
        
        
       // NSLog(@"cell text: %@", cell.idLabel.text);
        //cell.placeLabel.text = [NSString stringWithFormat:@"%@", place];
        //cell.timeLabel.text = [NSString stringWithFormat:@"%@", timeConverted];
        //cell.dateLabel.text = [NSString stringWithFormat:@"%@", dateConverted];
        
        
        
        return cell;
        
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   /*
    EditClassViewController *controller = [[EditClassViewController alloc] init];
    
    ScheduleResult *searchResult = [searchResults objectAtIndex:indexPath.row];
    
    controller.delegate = self;
    
    NSString *classFormat = @"%@";
    NSString *classfks = searchResult.class_fk;
    NSString *classfk = [NSString stringWithFormat:classFormat, classfks];
    
    sendClassfk = classfk;
    
    */
    
    
    //[self performSegueWithIdentifier:@"editClass" sender:self];
}


/*- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if ([searchResults count] == 0) {
 return nil;
 } else {
 return indexPath;
 }
 }*/

#pragma mark - Parsing Data info


- (void)showNetworkError
{
    [SVProgressHUD dismiss];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self.tableView reloadData];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Whoops..."
                              message:@"There was an error reading from Veracross. Please try again."
                              delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
    
    
}



-(void)pullData {
    

    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    searchResults = [NSMutableArray arrayWithCapacity:10];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
       
        
        NSString *studentID = [contentArray objectAtIndex:2];
        
        NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/enrollments.json?student=%@", studentID];
        NSURL *Url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:Url];
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSArray *classes = [NSJSONSerialization JSONObjectWithData:data
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
        //NSLog(@"classes array: %@", classes);
        
        //now we loop through all classes
        for (NSMutableDictionary *class in classes) {
            
            //we get individual data for each class
            
            NSString *classID = class[@"class_fk"];
            //NSLog(@"classID: %@", classID);
            NSString *classUrlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/classes/%@.json", classID];
            NSURL *classUrl = [NSURL URLWithString:classUrlString];
            NSURLRequest *classRequest = [NSURLRequest requestWithURL:classUrl];
            
            
            NSData *classData = [NSURLConnection sendSynchronousRequest:classRequest returningResponse:nil error:nil];
            NSDictionary *classDictionary = [NSJSONSerialization JSONObjectWithData:classData
                                                                            options:NSJSONReadingMutableContainers
                                                                              error:nil];
            //NSLog(@"classes dictionary: %@", classDictionary);
            if (classes == nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showNetworkError];
                });
                return;
                
            } else {
                if (classDictionary == nil) {
                    NSLog(@"classes dictionary: %@", classDictionary);
                } else {
            //probably should check here if array is empty before accessing first object
            //we shove the data from a classDictionary into class
            //class[@"teacher_full_name"] = classDictionary[@"teacher"][0];
                    if (classDictionary[@"teacher_full_name"] == nil) {
                        class[@"teacher_full_name"] = @"Not Provided";
                    } else {
                        class[@"teacher_full_name"] = classDictionary[@"teacher_full_name"];
                    }
                    
                    if (classDictionary[@"course"] == (NSString *)[NSNull null]) {
                        class[@"course"] = @"Not Provided";
                    } else {
                        class[@"course"] = classDictionary[@"course"];
                    }
                    
                    if (classDictionary[@"class_pk"] == (NSString *)[NSNull null]) {
                        class[@"class_pk"] = @"Not Provided";
                    } else {
                        class[@"class_pk"] = classDictionary[@"class_pk"];
                    }
            
                    if (classDictionary[@"teachers"][0][@"person_fk"] == (NSString *)[NSNull null]) {
                        class[@"person_fk"] = @"Not Provided";
                    } else {
                     class[@"person_fk"] = classDictionary[@"teachers"][0][@"person_fk"];   
                    }
                    
                    if (classDictionary[@"meeting_times"][0][@"block_abbreviation"] == (NSString *)[NSNull null]) {
                        class[@"block_abbreviation"] = @"Not Provided";
                    } else {
                        class[@"block_abbreviation"] = classDictionary[@"meeting_times"][0][@"block_abbreviation"];
                        
                    }
            
            ScheduleResult *searchResult = [[ScheduleResult alloc] init];
            searchResult.name = class[@"course"];
            searchResult.teacher = class[@"teacher_full_name"];
            searchResult.class_fk = class[@"class_pk"];
            searchResult.block = class[@"block_abbreviation"];
            
            [searchResults addObject:searchResult];
                    
            [searchResults sortUsingSelector:@selector(compareBlock:)];
                    
                    
            //NSLog(@"searchresult: %@", searchResult.block);
            //NSLog(@"course: %@ and teacher: %@", class[@"course"], class[@"teacher_full_name"] );
                }
            }
            
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //NSLog(@"dictionary: %@", classes);
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        });
        //NSLog(@"Done Initial Load!");
    });
    
}


@end
