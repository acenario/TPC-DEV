//
//  LunchViewController.h
//  GovsApp
//
//  Created by William Nee on 2/15/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LunchViewController : UIViewController

@property (strong, nonatomic) UIButton *govBtn;

- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end
