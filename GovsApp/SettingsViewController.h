//
//  SettingsViewController.h
//  GovsApp
//
//  Created by William Nee on 2/15/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SettingsViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate> {
    
}


@property (strong, nonatomic) UIButton *govBtn;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UIButton *logoutButton;


- (IBAction)logOut:(id)sender;
- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;


@end
