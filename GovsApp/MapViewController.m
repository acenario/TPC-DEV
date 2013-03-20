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
#import <Scringo/ScringoAgent.h>
#import "BuildingsClass.h"
#import "BuildingInfoViewController.h"


@interface MapViewController ()

@end

@implementation MapViewController {
    CLLocationManager *locationManager;
    //NSString *ann1;
    
}

@synthesize govBtn; //Not needed on Mountain Lion
@synthesize mapView;
@synthesize locationManager;
@synthesize location;





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



- (void)awesomemenu {
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    //Hiding Image Code
    UIImage *starImage2 = [UIImage imageNamed:@"icon-star3.png"];
    UIImage *storyMenuItemImage2 = [UIImage imageNamed:@"bg-menuitem3.png"];
    UIImage *storyMenuItemImagePressed2 = [UIImage imageNamed:@"bg-menuitem-highlighted3.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem8 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem9 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, starMenuItem7,starMenuItem8,starMenuItem9, nil];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectMake(8, 10, 100, 100) menus:menus];
    menu.tag = 22;
     
    
    menu.delegate = self;
    
    [self.view addSubview:menu];
    //[menu setHidden:TRUE];
    
   

    
	// customize menu
	/*
     menu.rotateAngle = M_PI/3;
     menu.menuWholeAngle = M_PI;
     menu.timeOffset = 0.2f;
     menu.farRadius = 180.0f;
     menu.endRadius = 100.0f;
     menu.nearRadius = 50.0f;
     */
    
    
     menu.startPoint = CGPointMake(160.0, 410.0);
    
    
	
    
    
}


- (void)awesomemenu2 {
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"bg-menuitem.png"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@"bg-menuitem-highlighted.png"];
    
    UIImage *starImage = [UIImage imageNamed:@"icon-star.png"];
    
    //Hiding Image Code
    UIImage *starImage2 = [UIImage imageNamed:@"icon-star3.png"];
    UIImage *storyMenuItemImage2 = [UIImage imageNamed:@"bg-menuitem3.png"];
    UIImage *storyMenuItemImagePressed2 = [UIImage imageNamed:@"bg-menuitem-highlighted3.png"];
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem5 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem6 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem7 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage2
                                                           highlightedImage:storyMenuItemImagePressed2
                                                               ContentImage:starImage2
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem8 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem9 = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    
    NSArray *menus = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, starMenuItem5, starMenuItem6, starMenuItem7,starMenuItem8,starMenuItem9, nil];
    
    AwesomeMenu *menu = [[AwesomeMenu alloc] initWithFrame:CGRectMake(8, 10, 100, 100) menus:menus];
    menu.tag = 23;
    
    
    menu.delegate = self;
    
    [self.view addSubview:menu];
    
    
    
    
    
	// customize menu
	/*
     menu.rotateAngle = M_PI/3;
     menu.menuWholeAngle = M_PI;
     menu.timeOffset = 0.2f;
     menu.farRadius = 180.0f;
     menu.endRadius = 100.0f;
     menu.nearRadius = 50.0f;
     */
    
    
    menu.startPoint = CGPointMake(240.0, 250.0);

	
    
    
}



- (void)AwesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    
    if (idx == 0) {
       //NSLog(@"Select the index : %d",idx);
       NSLog(@"Select the index : 0");
       [mapView setMapType:MKMapTypeHybrid];
        
    
    }
    
    
    if (idx == 1) {
            NSLog(@"Select the index : 1");
        [mapView setMapType:MKMapTypeStandard];
    }
    
    
    if (idx == 2) {
        NSLog(@"Select the index : 2");
    }
    
    
    if (idx == 7) {
        NSLog(@"Select the index : 7");
    }
    
    
    if (idx == 8) {
        NSLog(@"Select the index : 8");
        [mapView setMapType:MKMapTypeSatellite];
    }
    
}
- (void)AwesomeMenuDidFinishAnimationClose:(AwesomeMenu *)menu {
    NSLog(@"Menu was closed!");
}
- (void)AwesomeMenuDidFinishAnimationOpen:(AwesomeMenu *)menu {
    NSLog(@"Menu is open!");
    
}



- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    
    
    for (UIView *subview in [self.view subviews]) {
        
        if (UIDeviceOrientationLandscapeLeft) {
        
        if (subview.tag == 22){
            [subview removeFromSuperview];
            [self awesomemenu2];
            
            }
        }
        
        if (UIDeviceOrientationPortrait) {
            
            if (subview.tag == 23){
                [subview removeFromSuperview];
                [self awesomemenu];
                
            }
        }
            
    }
        
     
    

    
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    
    //static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *Building = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
    
    
    //Building.pinColor = MKPinAnnotationColorGreen;
    Building.image = [UIImage imageNamed:@"pushpin"];
    
    Building.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    Building.draggable = NO;
    Building.highlighted = YES;
    //Building.animatesDrop = NO;
    Building.canShowCallout = YES;
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    return Building;
    
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    
    //NSLog(@"Button action");
    
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Check in to Event!"
                              //message:@"This is my first app!"
                              message:@"This is a demonstration of how students can check into buildings and events on campus"
                              delegate:self
                              cancelButtonTitle:@"Check In Here"
                              otherButtonTitles:nil];
    [alertView show];
    
    
    
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [SVProgressHUD showSuccessWithStatus:@"Saved!"];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    

    
    //[ScringoAgent setTestMode:YES];
    
    //42.749378,-70.898541 Center of campus
   
    
    //Zoom in code
    MKCoordinateRegion regionZoom = { {0.0, 0.0 } , {0.0, 0.0} };
    regionZoom.center.latitude = 42.749651;
    regionZoom.center.longitude = -70.897538;
    regionZoom.span.longitudeDelta = 0.004f;
    regionZoom.span.latitudeDelta = 0.004f;
    [mapView setRegion:regionZoom animated:YES];
    
    
    //Field House
     MKCoordinateRegion region = { {0.0, 0.0 } , {0.0, 0.0} };
     region.center.latitude = 42.751919;
     region.center.longitude = -70.899347;
    
    
    BuildingsClass *ann = [[BuildingsClass alloc] init];
    ann.title = @"Field House";
    ann.subtitle = @"Sports Building";
    ann.coordinate = region.center;

    
    [mapView addAnnotation:ann];
    
    
    //Gym

    MKCoordinateRegion region1 = { {0.0, 0.0 } , {0.0, 0.0} };
    region1.center.latitude = 42.751371;
    region1.center.longitude = -70.89906;
    
    BuildingsClass *ann1 = [[BuildingsClass alloc] init];
    ann1.title = @"Gym";
    ann1.subtitle = @"Campus Facility";
    ann1.coordinate = region1.center;
    //ann1.image = [UIImage imageNamed:@"pushpin.png"];
    
    [mapView addAnnotation:ann1];
    
    //Hockey Rink
    
    MKCoordinateRegion region2 = { {0.0, 0.0 } , {0.0, 0.0} };
    region2.center.latitude = 42.750111;
    region2.center.longitude = -70.901203;
    
    BuildingsClass *ann2 = [[BuildingsClass alloc] init];
    ann2.title = @"Hockey Rink";
    ann2.subtitle = @"Campus Facility";
    ann2.coordinate = region2.center;
    
    
    [mapView addAnnotation:ann2];
    
    
    //Student Center
    
    MKCoordinateRegion region3 = { {0.0, 0.0 } , {0.0, 0.0} };
    region3.center.latitude = 42.750083;
    region3.center.longitude = -70.899763;
    
    BuildingsClass *ann3 = [[BuildingsClass alloc] init];
    ann3.title = @"Student Center";
    ann3.subtitle = @"Recreation";
    ann3.coordinate = region3.center;
    
    
    [mapView addAnnotation:ann3];
    
    //Frost
    
    MKCoordinateRegion region4 = { {0.0, 0.0 } , {0.0, 0.0} };
    region4.center.latitude = 42.750163;
    region4.center.longitude = -70.898804;
    
    BuildingsClass *ann4 = [[BuildingsClass alloc] init];
    ann4.title = @"Frost";
    ann4.subtitle = @"English & History";
    ann4.coordinate = region4.center;
    
    
    [mapView addAnnotation:ann4];
    
    //Library
    
    MKCoordinateRegion region5 = { {0.0, 0.0 } , {0.0, 0.0} };
    region5.center.latitude = 42.750137;
    region5.center.longitude = -70.898172;
    
    BuildingsClass *ann5 = [[BuildingsClass alloc] init];
    ann5.title = @"Library";
    ann5.subtitle = @"Campus Facility";
    ann5.coordinate = region5.center;
    
    
    [mapView addAnnotation:ann5];
    
    //Kaiser
    
    MKCoordinateRegion region6 = { {0.0, 0.0 } , {0.0, 0.0} };
    region6.center.latitude = 42.750317;
    region6.center.longitude = -70.897381;
    
    BuildingsClass *ann6 = [[BuildingsClass alloc] init];
    ann6.title = @"Kaiser";
    ann6.subtitle = @"Arts & Digital Media";
    ann6.coordinate = region6.center;
    
    
    [mapView addAnnotation:ann6];
    
    //PAC
    
    MKCoordinateRegion region7 = { {0.0, 0.0 } , {0.0, 0.0} };
    region7.center.latitude = 42.750174;
    region7.center.longitude = -70.896701;
    
    BuildingsClass *ann7 = [[BuildingsClass alloc] init];
    ann7.title = @"Wilkie Performing Arts Center";
    ann7.subtitle = @"Fine Arts, Dance, & Drama";
    ann7.coordinate = region7.center;
    
    
    [mapView addAnnotation:ann7];
    
    //Dining Hall
    
    MKCoordinateRegion region8 = { {0.0, 0.0 } , {0.0, 0.0} };
    region8.center.latitude = 42.749841;
    region8.center.longitude = -70.897594;
    
    BuildingsClass *ann8 = [[BuildingsClass alloc] init];
    ann8.title = @"Dining Hall";
    ann8.subtitle = @"Campus Facility";
    ann8.coordinate = region8.center;
    
    
    
    [mapView addAnnotation:ann8];
    
    //Phillips
    
    MKCoordinateRegion region9 = { {0.0, 0.0 } , {0.0, 0.0} };
    region9.center.latitude = 42.749651;
    region9.center.longitude = -70.897538;
    
    BuildingsClass *ann9 = [[BuildingsClass alloc] init];
    ann9.title = @"Phillips";
    ann9.subtitle = @"Main Campus Building";
    ann9.coordinate = region9.center;
    
    
    [mapView addAnnotation:ann9];
    
    //Chapel
    
    MKCoordinateRegion region10 = { {0.0, 0.0 } , {0.0, 0.0} };
    region10.center.latitude = 42.749513;
    region10.center.longitude = -70.896697;
    
    BuildingsClass *ann10 = [[BuildingsClass alloc] init];
    ann10.title = @"Chapel";
    ann10.subtitle = @"Campus Building";
    ann10.coordinate = region10.center;
    
    
    [mapView addAnnotation:ann10];
    
    //Math & Science Center
    
    MKCoordinateRegion region11 = { {0.0, 0.0 } , {0.0, 0.0} };
    region11.center.latitude = 42.748747;
    region11.center.longitude = -70.897564;
    
    BuildingsClass *ann11 = [[BuildingsClass alloc] init];
    ann11.title = @"Schumann Science Center";
    ann11.subtitle = @"Math & Science Building";
    ann11.coordinate = region11.center;
    
    
    [mapView addAnnotation:ann11];
    
    //Parsons
    
    MKCoordinateRegion region12 = { {0.0, 0.0 } , {0.0, 0.0} };
    region12.center.latitude = 42.748551;
    region12.center.longitude = -70.898509;
    
    BuildingsClass *ann12 = [[BuildingsClass alloc] init];
    ann12.title = @"Parsons";
    ann12.subtitle = @"Foreign Language Building";
    ann12.coordinate = region12.center;
    
    
    [mapView addAnnotation:ann12];
    
    //Health Center
    
    MKCoordinateRegion region13 = { {0.0, 0.0 } , {0.0, 0.0} };
    region13.center.latitude = 42.748471;
    region13.center.longitude = -70.89791;
    
    BuildingsClass *ann13 = [[BuildingsClass alloc] init];
    ann13.title = @"Health Center";
    ann13.subtitle = @"Campus Building";
    ann13.coordinate = region13.center;
    
    
    [mapView addAnnotation:ann13];
    
    //Farm House
    
    MKCoordinateRegion region14 = { {0.0, 0.0 } , {0.0, 0.0} };
    region14.center.latitude = 42.75273;
    region14.center.longitude = -70.901683;
    
    BuildingsClass *ann14 = [[BuildingsClass alloc] init];
    ann14.title = @"Farm House";
    ann14.subtitle = @"Dorm";
    ann14.coordinate = region14.center;
    
    
    [mapView addAnnotation:ann14];
    
    //Dogget Dorm
    
    MKCoordinateRegion region15 = { {0.0, 0.0 } , {0.0, 0.0} };
    region15.center.latitude = 42.752727;
    region15.center.longitude = -70.901006;
    
    BuildingsClass *ann15 = [[BuildingsClass alloc] init];
    ann15.title = @"Dogget";
    ann15.subtitle = @"Dorm";
    ann15.coordinate = region15.center;
    
    
    [mapView addAnnotation:ann15];
    
    //Cottage
    
    MKCoordinateRegion region16 = { {0.0, 0.0 } , {0.0, 0.0} };
    region16.center.latitude = 42.752304;
    region16.center.longitude = -70.901011;
    
    BuildingsClass *ann16 = [[BuildingsClass alloc] init];
    ann16.title = @"Cottage";
    ann16.subtitle = @"Dorm";
    ann16.coordinate = region16.center;
    
    
    [mapView addAnnotation:ann16];
    
    //Moody
    
    MKCoordinateRegion region17 = { {0.0, 0.0 } , {0.0, 0.0} };
    region17.center.latitude = 42.752335;
    region17.center.longitude = -70.900473;
    
    BuildingsClass *ann17 = [[BuildingsClass alloc] init];
    ann17.title = @"Moody";
    ann17.subtitle = @"Dorm";
    ann17.coordinate = region17.center;
    
    
    [mapView addAnnotation:ann17];
    
    //Nannie B
    
    MKCoordinateRegion region18 = { {0.0, 0.0 } , {0.0, 0.0} };
    region18.center.latitude = 42.751951;
    region18.center.longitude = -70.900539;
    
    BuildingsClass *ann18 = [[BuildingsClass alloc] init];
    ann18.title = @"Nannie B.";
    ann18.subtitle = @"Dorm";
    ann18.coordinate = region18.center;
    
    
    [mapView addAnnotation:ann18];
    
    //Perkins
    
    MKCoordinateRegion region19 = { {0.0, 0.0 } , {0.0, 0.0} };
    region19.center.latitude = 42.751005;
    region19.center.longitude = -70.900011;
    
    BuildingsClass *ann19 = [[BuildingsClass alloc] init];
    ann19.title = @"Perkins";
    ann19.subtitle = @"Dorm";
    ann19.coordinate = region19.center;
    
    
    [mapView addAnnotation:ann19];
    
    //Pierce
    
    MKCoordinateRegion region20 = { {0.0, 0.0 } , {0.0, 0.0} };
    region20.center.latitude = 42.749075;
    region20.center.longitude = -70.897219;
    
    BuildingsClass *ann20 = [[BuildingsClass alloc] init];
    ann20.title = @"Pierce";
    ann20.subtitle = @"Dorm";
    ann20.coordinate = region20.center;
    
    
    [mapView addAnnotation:ann20];
    
    //Eames
    
    MKCoordinateRegion region21 = { {0.0, 0.0 } , {0.0, 0.0} };
    region21.center.latitude = 42.747634;
    region21.center.longitude = -70.898235;
    
    BuildingsClass *ann21 = [[BuildingsClass alloc] init];
    ann21.title = @"Eames";
    ann21.subtitle = @"Dorm";
    ann21.coordinate = region21.center;
    
    
    [mapView addAnnotation:ann21];
    
    //Ingham
    
    MKCoordinateRegion region22 = { {0.0, 0.0 } , {0.0, 0.0} };
    region22.center.latitude = 42.747745;
    region22.center.longitude = -70.899265;
    
    BuildingsClass *ann22 = [[BuildingsClass alloc] init];
    ann22.title = @"ICC";
    ann22.subtitle = @"Dorm";
    ann22.coordinate = region22.center;
    ann2.image = [UIImage imageNamed:@"Icon-Small.png"];
    
    
    [mapView addAnnotation:ann22];
    
    [self awesomemenu];
 
    
    
    
    /*locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
    [locationManager startUpdatingLocation];*/
    
    
    
    
    
	// Do any additional setup after loading the view.
    
    //[self screenUpdate2];
    
    //[ScringoAgent scringoActivationButtonOpensToLeft:YES];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    
    
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
   
    
    

    
   
}


-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    location = newLocation.coordinate;
    
}


-(void)myCommandClicked:(NSNotification *)aNotification {
    NSLog(@"User selected my custom command. Command id is =%@", [aNotification userInfo]);
    
    // The rest of your code
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
    
    [ScringoAgent openSidebar];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}





@end
