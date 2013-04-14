//
//  DaySearchViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 3/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "DaySearchViewController.h"
#import "SearchResultCell.h"


static NSString *const SearchResultCellIdentifier = @"SearchResultCell";
static NSString *const NothingFoundCellIdentifier = @"NothingFoundCell";

@interface DaySearchViewController ()


@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation DaySearchViewController {
    NSMutableArray *searchResults;
    NSArray *myJSON;
    BOOL isLoading;
    
}

@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;


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



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 80;
    
    NSLog(@"delegate:%@ dataSource:%@", self.tableView.delegate, self.tableView.dataSource);
	
    UINib *cellNib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:
     NothingFoundCellIdentifier];
    
    //[self pullData];
    
    
    //Show keyboard instantly
    //[self.searchBar becomeFirstResponder];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.tableView addGestureRecognizer:gestureRecognizer];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated
{
    
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
        //NSLog(@"nameUP: %@, timeUP: %@", searchResult.name, searchResult.time);
        
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
        
     
        
        //NSLog(@"name: %@, place: %@", searchResult.name, searchResult.place);
        
        cell.placeLabel.text = [NSString stringWithFormat:@"%@", place];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@", timeConverted];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@", dateConverted];

        
        
        return cell;
        
    }
    

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
        NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/events.json?date_from=%@&date_to=%@",escapedSearchText,escapedSearchText];
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
    
    //NSString *today = [dateFormatter stringFromDate:currDate];
    //NSString *nextWeek = [dateFormatter stringFromDate:currDateAddedbySeven];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
    
    searchResults = [NSMutableArray arrayWithCapacity:10];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSURL *url = [self urlWithSearchText:@"2013-04-16"];
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
        NSLog(@"Done Initial Load!");
    });
    
    
}




#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if ([searchBar.text length] > 0) {
        [searchBar resignFirstResponder];
        
        [self.tableView reloadData];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [SVProgressHUD showWithStatus:@"Loading" maskType:SVProgressHUDMaskTypeGradient];
        
        
        searchResults = [NSMutableArray arrayWithCapacity:10];
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
        
        NSURL *url = [self urlWithSearchText:searchBar.text];
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
         NSLog(@"Done Search!");
            });
        
    }

    
    
    //No need to edit below this line
    
    if ([searchBar.text isEqualToString:@"Emilie MacDonald"]) {
        
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Congratulations!"
                                  //message:@"This is my first app!"
                                  message:@"You found out that Arjun loves Emilie."
                                  delegate:self
                                  cancelButtonTitle:@"But does she?"
                                  otherButtonTitles:nil];
        [alertView show];

    }
    
    //[self.tableView reloadData];
        
        /*
         [searchBar resignFirstResponder];
         searchResults = [NSMutableArray arrayWithCapacity:10];
         
         if (![searchBar.text isEqualToString:@"justin bieber"]) {
         for (int i = 0; i < 3; i++) {
         SearchResult *searchResult = [[SearchResult alloc] init];
         searchResult.name = [NSString stringWithFormat:@"Fake Result %d for", i];
         searchResult.place = searchBar.text;
         searchResult.time = searchBar.text;
         [searchResults addObject:searchResult];
         
         }
         }*/
    
        
}


#pragma mark - Sidebar Button Code
- (IBAction)searchBtn:(id)sender {
    [ScringoAgent openSidebar];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

@end
