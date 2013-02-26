//
//  MapViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "MapViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
@implementation MapViewController

@synthesize managedObjectContext;
@synthesize mapView;
- (IBAction)showUser
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.mapView. userLocation.coordinate, 1000, 1000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}
- (IBAction)showLocations
{
    MKCoordinateRegion region = [self regionForAnnotations:locations];
    [self.mapView setRegion:region animated:YES];
}

@end
@implementation MapViewController {
    NSArray *locations;
}

@synthesize govBtn; //Not needed on Mountain Lion





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)screenUpdate {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, width, 44)];
    [self.view addSubview:naviBarObj];
    
    NSInteger red   = 178;
    NSInteger green = 8;
    NSInteger blue  = 56;
    
    
    [naviBarObj setTintColor:[UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:1.0]];
    UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Governors"];
    naviBarObj.items = [NSArray arrayWithObjects: navigItem,nil];
    
    self.govBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    govBtn.frame = CGRectMake(8, 10, 34, 24);
    [govBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [govBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.govBtn];
}

- (void)screenUpdate2 {
    
    self.govBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    govBtn.frame = CGRectMake(8, 10, 34, 24);
    [govBtn setBackgroundImage:[UIImage imageNamed:@"menuButton.png"] forState:UIControlStateNormal];
    [govBtn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.govBtn];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //[self screenUpdate2];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //[self screenUpdate2];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    if (![self.slidingViewController.underRightViewController isKindOfClass:[UnderRightViewController class]]) {
        self.slidingViewController.underRightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"UnderRight"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (IBAction)revealMenu:(id)sender
{
    [self.slidingViewController anchorTopViewTo:ECRight];
}*/

- (IBAction)searchBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECLeft];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}
- (void)updateLocations
{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Location"inManagedObjectContext:self.managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray * foundObjects = [self.managedObjectContext executeFetchRequest:
                              fetchRequest error:&error];
    if (foundObjects == nil) {
        FATAL_CORE_DATA_ERROR(error);
        return;
    }
    
    if (locations != nil) {
        [self.mapView removeAnnotations:locations];
    }
    locations = foundObjects;
    [self.mapView addAnnotations:locations]; }
- (MKCoordinateRegion)regionForAnnotations:(NSArray *)annotations {
    MKCoordinateRegion region;
    if ([annotations count] == 0) {
        region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.
                                                    coordinate, 1000, 1000);
    } else if ([annotations count] == 1) {
        id <MKAnnotation> annotation = [annotations lastObject];
        region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 
                                                    1000);
    } else {
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        ￼￼￼￼￼    topLeftCoord.longitude = 180;
        CLLocationCoordinate2D bottomRightCoord; bottomRightCoord.latitude = 90; bottomRightCoord.longitude = -180;
        for (id <MKAnnotation> annotation in annotations) {
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinateê
                                         .latitude);
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.ê
                                          coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.ê
                                             coordinate.latitude);
            bottomRightCoord.longitude = fmax(b
                    // It said to add above show locations.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateLocations];
    
    if ([locations count] > 0) {
        [self showLocations];
    } 
}




@end
