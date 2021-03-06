//
//  VCLoginViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 4/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Scringo/ScringoAgent.h>

@interface VCLoginViewController : UIViewController <NSXMLParserDelegate, UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;


- (IBAction)login:(id)sender;
- (IBAction)exit:(id)sender;



@end
