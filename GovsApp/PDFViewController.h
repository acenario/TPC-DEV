//
//  DirectionsViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/27/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface PDFViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;

- (IBAction)searchBtn:(id)sender;
- (IBAction)shieldBtn:(id)sender;

@end
