//
//  FineArtsViewController.h
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/26/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"

@interface FineArtsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *viewWeb;

@end