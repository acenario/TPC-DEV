//
//  MapViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/13/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MapViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction)showUser;
- (IBAction)showLocations;


@property (strong, nonatomic) UIButton *govBtn;

//- (IBAction)logOutButtonTapAction:(id)sender; --> Removed Logout Button

@end
