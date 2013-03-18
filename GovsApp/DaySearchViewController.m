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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 70;
	
    UINib *cellNib = [UINib nibWithNibName:@"SearchResultCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:SearchResultCellIdentifier];
    
    cellNib = [UINib nibWithNibName:NothingFoundCellIdentifier bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:
     NothingFoundCellIdentifier];
    
    
    //Code to calculate date
    NSDate *currDate = [NSDate date];
    NSDate *currDateAddedbySeven = [NSDate date];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    dayComponent.day = 7;
    
    
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    currDateAddedbySeven = [theCalendar dateByAddingComponents:dayComponent toDate:currDate options:0];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd"]; //HH:mm:ss
    
    NSString *dateString = [dateFormatter stringFromDate:currDate];
    NSString *dateStringAddedSeven = [dateFormatter stringFromDate:currDateAddedbySeven];
    NSLog(@"Today: %@",dateString);
    NSLog(@"One week from today: %@", dateStringAddedSeven);
    
    //Show keyboard instantly
    //[self.searchBar becomeFirstResponder];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        //NSString *place = searchResult.place;
        NSLog(@"placeVALUE: %@", place);
        
        
        if (place == (NSString *)[NSNull null]) {
            place = @"Location not provided";
        }
        
        NSString *timeValue = searchResult.time;
        if (timeValue == (NSString *)[NSNull null]) {
            timeValue = @"Time not provided";
        }
        
        NSLog(@"name: %@, place: %@", searchResult.name, searchResult.place);
        
        cell.placeLabel.text = [NSString stringWithFormat:@"%@", place];
        cell.timeLabel.text = [NSString stringWithFormat:@"%@", timeValue];

        
        //NSLog(@"name: %@, time: %@", searchResult.name, searchResult.time);
        
        //NSLog(@"name label: %@, time label: %@", cell.nameLabel.text, cell.timeLabel.text);
        
        
        
        return cell;
        
    }
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([searchResults count] == 0) {
        return nil;
    } else {
        return indexPath;
    }
}

#pragma mark - Parsing Data info

- (NSURL *)urlWithSearchText:(NSString *)searchText

    {
        
        NSString *escapedSearchText = [searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/events.json?date_from=%@&date_to=2013-04-06",escapedSearchText];
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
    
    
    //NSLog(@"name data: %@, time data: %@", searchResult.name, searchResult.time);
    

    
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




#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if ([searchBar.text length] > 0) {
        [searchBar resignFirstResponder];
        
        searchResults = [NSMutableArray arrayWithCapacity:10];
        
        NSURL *url = [self urlWithSearchText:searchBar.text];
        NSString *jsonString = [self performStoreRequestWithURL:url];
        
        
        if (jsonString == nil) {
            [self showNetworkError];
            return;
        }
        
        NSDictionary *dictionary = [self parseJSON:jsonString];
        
        if (dictionary == nil) {
            [self showNetworkError];
            return;
        }
        
        NSLog(@"Dictionary '%@'", dictionary);
        [self parseArray:myJSON];
        
        [self.tableView reloadData];
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