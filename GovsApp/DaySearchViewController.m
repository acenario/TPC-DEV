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


#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    searchResults = [NSMutableArray arrayWithCapacity:10];
    
    if (![searchBar.text isEqualToString:@"justin bieber"]) {
    for (int i = 0; i < 3; i++) {
        SearchResult *searchResult = [[SearchResult alloc] init];
        searchResult.name = [NSString stringWithFormat:@"Fake Result %d for", i];
        searchResult.place = searchBar.text;
        searchResult.time = searchBar.text;
        [searchResults addObject:searchResult];
        /*[searchResults addObject:[NSString stringWithFormat:@"Fake Result %d for '%@'", i, searchBar.text]];*/
        }
    }
    
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
    
    [self.tableView reloadData];
}


#pragma mark - Sidebar Button Code
- (IBAction)searchBtn:(id)sender {
    [ScringoAgent openSidebar];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

@end
