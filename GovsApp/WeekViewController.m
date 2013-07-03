//
//  DayViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "WeekViewController.h"
#import "SearchResultCell.h"

static NSString *const SearchResultCellIdentifier = @"SearchResultCell";
static NSString *const NothingFoundCellIdentifier = @"NothingFoundCell";

@interface WeekViewController ()

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation WeekViewController {
    NSMutableArray *searchResults;
    NSArray *myJSON;
    NSString *addedDate;
    
    //Check in code
    NSString *noTimeAndPlace;
    NSString *noPlace;
    NSString *NoTime;
    NSString *attendingEvent;
    
    //Reminders Code
    NSString *title;
    NSDate *remindersDate;
    
    id setReminder;
    id createReminder;
}

@synthesize tableView = _tableView;
@synthesize eventStore = _eventStore;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) hideKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.rowHeight = 80;
	
    UINib *cellNib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
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

- (NSString *)userVisibleDateTimeStringForRFC3339DateTimeString:(NSString *)rfc3339DateTimeString
// Returns a user-visible date time string that corresponds to the
// specified RFC 3339 date time string. Note that this does not handle
// all possible RFC 3339 date time strings, just one of the most common
// styles.
{
    NSString *          userVisibleDateTimeString;
    NSDateFormatter *   rfc3339DateFormatter;
    NSLocale *          enUSPOSIXLocale;
    NSDate *            date;
    NSDateFormatter *   userVisibleDateFormatter;
    
    userVisibleDateTimeString = nil;
    
    // Convert the RFC 3339 date time string to an NSDate.
    
    rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    
    enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'Z'"];
    //[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    date = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    
    
    if (date != nil) {
        
        // Convert the NSDate to a user-visible date string.
        
        userVisibleDateFormatter = [[NSDateFormatter alloc] init];
        assert(userVisibleDateFormatter != nil);
        
        
        //[userVisibleDateFormatter setDateStyle:NSDateFormatterShortStyle];
        [userVisibleDateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        userVisibleDateTimeString = [userVisibleDateFormatter stringFromDate:date];
    }
    
    if (date == nil) {
        userVisibleDateTimeString = @"Not provided";
    }
    
    return userVisibleDateTimeString;
}

- (NSString *)userVisibleDateStringForDateString:(NSString *)rfc3339DateTimeString
// Returns a user-visible date time string that corresponds to the
// specified RFC 3339 date time string. Note that this does not handle
// all possible RFC 3339 date time strings, just one of the most common
// styles.
{
    NSString *          userVisibleDateTimeString;
    NSDateFormatter *   rfc3339DateFormatter;
    NSLocale *          enUSPOSIXLocale;
    NSDate *            date;
    NSDateFormatter *   userVisibleDateFormatter;
    
    userVisibleDateTimeString = nil;
    
    // Convert the RFC 3339 date time string to an NSDate.
    
    rfc3339DateFormatter = [[NSDateFormatter alloc] init];
    
    enUSPOSIXLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    
    [rfc3339DateFormatter setLocale:enUSPOSIXLocale];
    [rfc3339DateFormatter setDateFormat:@"yyyy-MM-dd"];
    //[rfc3339DateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    date = [rfc3339DateFormatter dateFromString:rfc3339DateTimeString];
    //reminders code
    remindersDate = date;
    
    if (date != nil) {
        
        // Convert the NSDate to a user-visible date string.
        
        userVisibleDateFormatter = [[NSDateFormatter alloc] init];
        assert(userVisibleDateFormatter != nil);
        
        
        //[userVisibleDateFormatter setDateFormat:@"MM'/'dd'/'YY"];
        [userVisibleDateFormatter setDateStyle:NSDateFormatterFullStyle];
        
        userVisibleDateTimeString = [userVisibleDateFormatter stringFromDate:date];
    }
    return userVisibleDateTimeString;
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

- (NSString *)placeForDisplay:(NSString *)place
{
    //if (place == (NSString *)@"Frost Library") {
    //if ([place isEqualToString:@"Wilkie Ctr., Remis Lobby"]) {
    if ([[NSString stringWithFormat:@"%@", place] isEqualToString:@"Wilkie Ctr., Remis Lobby"]) {
        return @"Wilkie Performing Arts Center";
        
    } else if ([[NSString stringWithFormat:@"%@", place] isEqualToString:@"Wilkie Ctr., Auditorium"]) {
        return @"Wilkie Performing Arts Center";
        
        /*} else if ([place isEqualToString:@"audiobook"]) {
         return @"Audio Book";*/
    } else {
        return place;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:
                NothingFoundCellIdentifier];
        
    } else {
        
        SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
        
        SearchResult *searchResult = [searchResults objectAtIndex:indexPath.row];
        
        
        cell.nameLabel.text = searchResult.name;
        
        NSString *place = [self placeForDisplay:searchResult.place];
        if (place == (NSString *)[NSNull null]) {
            place = @"Not provided";
        }
        
        NSString *timeValue = searchResult.time;
        
        if (timeValue == (NSString *)[NSNull null]) {
            timeValue = nil;
        }
        
        NSString *timeConverted = [self userVisibleDateTimeStringForRFC3339DateTimeString:timeValue];
        
        
        NSString *dateValue = searchResult.startDate;
        
        NSString *dateConverted = [self userVisibleDateStringForDateString:dateValue];
        
        
        cell.placeLabel.text = [NSString stringWithFormat:@"%@", place];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@", timeConverted];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@", dateConverted];
        
        
        
        return cell;
        
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResult *searchResult = [searchResults objectAtIndex:indexPath.row];
    
    
    NSString *place = [self placeForDisplay:searchResult.place];
    if (place == (NSString *)[NSNull null]) {
        place = @"Not provided";
    }
    
    
    NSString *timeValue = searchResult.time;
    if (timeValue == (NSString *)[NSNull null]) {
        timeValue = nil;
    }
    NSString *timeConverted = [self userVisibleDateTimeStringForRFC3339DateTimeString:timeValue];
    
    
    NSString *dateValue = searchResult.startDate;
    NSString *dateConverted = [self userVisibleDateStringForDateString:dateValue];
    
    title = searchResult.name;
    
    
    
    if ((place == (NSString *)[NSNull null]) && (timeValue == (NSString *)[NSNull null])) {
     NSString *attendingNoTimeAndPlace = [NSString stringWithFormat:@"is Attending %@ on %@", searchResult.name, dateConverted];
     noTimeAndPlace = attendingNoTimeAndPlace;
     NSString *message = [NSString stringWithFormat:@"Would you like to check into: %@?", searchResult.name];
     
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Check in to an Event!"
                                  message:message
                                  delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"Check In Here!", @"Add to Reminders", nil];
     [alertView setTag:0];
     [alertView show];
     
     } else if (place == (NSString *)[NSNull null]) {
     NSString *attendingNoPlace = [NSString stringWithFormat:@"is Attending %@ at %@", searchResult.name, searchResult.time];
     noPlace = attendingNoPlace;
     
     NSString *message = [NSString stringWithFormat:@"Would you like to check into: %@?", searchResult.name];
     
     
         UIAlertView *alertView = [[UIAlertView alloc]
                                   initWithTitle:@"Check in to an Event!"
                                   message:message
                                   delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@"Check In Here!", @"Add to Reminders", nil];
     [alertView setTag:1];
     [alertView show];
     
     
     } else if (timeValue == (NSString *)[NSNull null]) {
     NSString *attendingNoTime = [NSString stringWithFormat:@"is Attending %@ in %@", searchResult.name, searchResult.place];
     NoTime = attendingNoTime;
     
     NSString *message = [NSString stringWithFormat:@"Would you like to check into: %@?", searchResult.name];
     
     
         UIAlertView *alertView = [[UIAlertView alloc]
                                   initWithTitle:@"Check in to an Event!"
                                   message:message
                                   delegate:self
                                   cancelButtonTitle:@"Cancel"
                                   otherButtonTitles:@"Check In Here!", @"Add to Reminders", nil];
     [alertView setTag:2];
     [alertView show];
     
     } else {
     NSString *attending = [NSString stringWithFormat:@"is Attending %@ at %@ in %@", searchResult.name, timeConverted, searchResult.place];
     attendingEvent = attending;
     
     NSString *message = [NSString stringWithFormat:@"Would you like to check into: %@?", searchResult.name];
     
     
     UIAlertView *alertView = [[UIAlertView alloc]
     initWithTitle:@"Check in to an Event!"
     message:message
     delegate:self
     cancelButtonTitle:@"Cancel"
     otherButtonTitles:@"Check In Here!", @"Add to Reminders", nil];
     [alertView setTag:3];
     [alertView show];
     
     }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if(alertView.tag == 0) //No Time and Place
    {
        if (buttonIndex == 0) {
            //NSLog(@"user pressed Cancel");
            
        }
        else if (buttonIndex == 1) {
            [ScringoAgent postToFeed:noTimeAndPlace];
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
        }
        else if (buttonIndex == 2) {
            
            [SVProgressHUD showSuccessWithStatus:@"Reminder Added!"];
        }
    }
    
    else if(alertView.tag == 1)
    {
        if (buttonIndex == 0) {
            //NSLog(@"user pressed Cancel");
            
        }
        else if (buttonIndex == 1) {
            [ScringoAgent postToFeed:noPlace];
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
        }
        else if (buttonIndex == 2) {
            [SVProgressHUD showSuccessWithStatus:@"Reminder Added!"];
        }
    }
    
    else if(alertView.tag == 2)
    {
        if (buttonIndex == 0) {
            //NSLog(@"user pressed Cancel");
            
        }
        else if (buttonIndex == 1) {
            [ScringoAgent postToFeed:NoTime];
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
        }
        else if (buttonIndex == 2) {
            [SVProgressHUD showSuccessWithStatus:@"Reminder Added!"];
        }
    }
    
    else if(alertView.tag == 3)
    {
        if (buttonIndex == 0) {
            //NSLog(@"user pressed Cancel");
            
        }
        else if (buttonIndex == 1) {
            [ScringoAgent postToFeed:attendingEvent];
            [SVProgressHUD showSuccessWithStatus:@"Saved!"];
        }
        else if (buttonIndex == 2) {
            [SVProgressHUD showSuccessWithStatus:@"Reminder Added!"];
        }
    }
    
    setReminder = @"set";
    [self setReminder];
    
}

-(void)createReminder
{
    EKReminder *reminder = [EKReminder reminderWithEventStore:self.eventStore];
    
        
        reminder.title = title;
        
        reminder.calendar = [_eventStore defaultCalendarForNewReminders];
        
        NSDate *date = remindersDate;
        
        EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date];
        
        [reminder addAlarm:alarm];
        
        NSLog(@"hello from %@ and date: %@", title, remindersDate);
    
    NSError *error = nil;    
    
    [_eventStore saveReminder:reminder commit:YES error:&error];
    
    if (error)
        NSLog(@"error = %@", error);
    
}

- (void)setReminder {
    
    if (_eventStore == nil)
    {
        _eventStore = [[EKEventStore alloc]init];
        
        [_eventStore requestAccessToEntityType:EKEntityTypeReminder completion:^(BOOL granted, NSError *error) {
            
            if (!granted)
                NSLog(@"Access to store not granted");
        }];
    }
    
    if (_eventStore != nil) {
        
    
        [self createReminder];
    }
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

- (NSURL *)urlWithSearchText:(NSString *)searchText

{
    
    NSString *escapedSearchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/events.json?date_from=%@&date_to=%@",escapedSearchText,addedDate];
    NSURL *url = [NSURL URLWithString:urlString];
    return url;
}

- (NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        return nil;
    }
    return resultString;
}

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

- (SearchResult *)parseName:(NSDictionary *)dictionary
{
    SearchResult *searchResult = [[SearchResult alloc] init];
    
    searchResult.name = [dictionary objectForKey:@"description"];
    searchResult.place = [dictionary objectForKey:@"location"];
    searchResult.time = [dictionary objectForKey:@"start_time"];
    searchResult.startDate = [dictionary objectForKey:@"start_date"];
    
    
    //NSLog(@"start date: %@", searchResult.startDate);
    
    
    
    return searchResult;
}

- (void)parseArray:(NSArray *)array
{
    
    
    if (myJSON == nil) {
        NSLog(@"Expected an array");
        return;
    }
    
    for (NSDictionary *resultDict in myJSON) {
        SearchResult *searchResult;
        
        //NSString *description = [resultDict objectForKey:@"description"];
        
        
        //if ([description isEqualToString:@"March Break"]) {
        searchResult = [self parseName:resultDict];
        
        //}
        
        
        if (searchResult != nil) {
            
            [searchResults addObject:searchResult];
        }
        
        
        /*NSLog(@"name: %@, start_time: %@, location: %@", [resultDict objectForKey:@"description"], [resultDict objectForKey:@"start_time"], [resultDict objectForKey:@"location"]);*/
    }
}

- (NSDictionary *)parseJSON:(NSString *)jsonString
{
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSError *error;
    
    id resultObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (resultObject == nil) {
        NSLog(@"JSON Error: %@", error);
        return nil;
    }
    
    NSArray *parsedJSON = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    myJSON = parsedJSON;
    
    
    
    if (![resultObject isKindOfClass:[NSArray class]]) {
        NSLog(@"JSON Error: Expected array!");
        return nil;
    }
    
    
    return resultObject;
}

- (void)pullData {
    
    NSDate *currDate = [NSDate date];
    NSDate *currDateAddedbySeven = [NSDate date];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 7;
    
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    currDateAddedbySeven = [theCalendar dateByAddingComponents:dayComponent toDate:currDate options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //HH:mm:ss
    
    NSString *today = [dateFormatter stringFromDate:currDate];
    NSString *nextWeek = [dateFormatter stringFromDate:currDateAddedbySeven];
    addedDate = nextWeek;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    searchResults = [NSMutableArray arrayWithCapacity:10];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSURL *url = [self urlWithSearchText:today];
        NSString *jsonString = [self performStoreRequestWithURL:url];
        
        
        if (jsonString == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showNetworkError];
            });
            return;
        }
        
        NSDictionary *dictionary = [self parseJSON:jsonString];
        
        if (dictionary == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self showNetworkError];
            });
            return;
            
        }
        
        //NSLog(@"Dictionary '%@'", dictionary);
        [self parseArray:myJSON];
        [searchResults sortUsingSelector:@selector(compareName:)];
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        });
        //NSLog(@"Done Initial Load!");
    });
    
    
}


@end
