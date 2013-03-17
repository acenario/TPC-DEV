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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
    
    
    if ([searchResults count] == 0) {
        return [tableView dequeueReusableCellWithIdentifier:
                NothingFoundCellIdentifier];
    } else {
        SearchResultCell *cell = (SearchResultCell *)[tableView dequeueReusableCellWithIdentifier:SearchResultCellIdentifier];
        
        SearchResult *searchResult = searchResults[indexPath.row];
        cell.nameLabel.text = searchResult.name;
        cell.placeLabel.text = searchResult.place;
        cell.timeLabel.text = searchResult.place;
    }
    
    
    return cell;
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
        NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@api.veracross.com/gda/v1/events.json?date_from=%@", escapedSearchText];
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




#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    if ([searchBar.text length] > 0) {
        [searchBar resignFirstResponder];
        searchResults = [NSMutableArray arrayWithCapacity:10];
        
        NSURL *url = [self urlWithSearchText:searchBar.text];
        NSLog(@"URL '%@'", url);
        
        NSString *jsonString = [self performStoreRequestWithURL:url];
        NSLog(@"Received JSON string '%@'", jsonString);
        
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
