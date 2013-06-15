//
//  ScringoSampleViewController.h
//  ScringoSample
//
//  Created by Guy Federovsky on 03/03/13.
//  Copyright (c) 2013 Scringo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Scringo/ScringoLikeButton.h>

@interface ScringoSampleViewController : UIViewController

@property (retain, nonatomic) IBOutlet UINavigationBar *navBar;
@property (retain, nonatomic) IBOutlet UIImageView *riverImage;
@property (retain, nonatomic) IBOutlet ScringoLikeButton *riverLikeButton;

- (IBAction)addRiverFeed:(id)sender;
@end
