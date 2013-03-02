//
//  MapViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UnderRightViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "SVProgressHUD.h"



@interface MapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIAlertViewDelegate> {
    MKMapView *mapView;
    CLLocationCoordinate2D location;
}



- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;
//- (IBAction)setMap:(id)sender;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (strong, nonatomic) UIButton *govBtn;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, readonly) CLLocationCoordinate2D location;

//- (IBAction)logOutButtonTapAction:(id)sender; --> Removed Logout Button

@end
