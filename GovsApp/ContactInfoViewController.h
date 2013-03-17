//
//  ContactInfoViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/28/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface ContactInfoViewController : UITableViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;
@property (strong, nonatomic) IBOutlet UIWebView *viewAdmissions;
@property (strong, nonatomic) IBOutlet UIWebView *viewHealth;
@property (strong, nonatomic) IBOutlet UIWebView *viewSecurity;
@property (strong, nonatomic) IBOutlet UIWebView *viewAddress;
@property (strong, nonatomic) IBOutlet UIWebView *viewMap;

@end
