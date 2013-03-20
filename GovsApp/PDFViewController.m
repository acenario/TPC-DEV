//
//  DirectionsViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/27/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "PDFViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import <Scringo/ScringoAgent.h>

@interface PDFViewController ()

@end

@implementation PDFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)loadWebView {
    //[SVProgressHUD showWithStatus:@"Loading Content" maskType:SVProgressHUDMaskTypeGradient];
    self.viewWeb.delegate = self;
    NSString *fullURL = @"http://www.thegovernorsacademy.org/page.cfm?p=429";
    
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_viewWeb loadRequest:requestObj];
    
    //[SVProgressHUD showSuccessWithStatus:@"Success!"];
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [SVProgressHUD showWithStatus:@"Loading"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [SVProgressHUD showSuccessWithStatus:@"Done!"];
    //[SVProgressHUD popActivity];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [SVProgressHUD dismiss];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    // load error, hide the activity indicator in the status bar
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    // report the error inside the webview
    NSString* errorString = [NSString stringWithFormat:
                             @"<html><center><font size=+5 color='red'>An error occurred:<br>%@</font></center></html>",
                             error.localizedDescription];
    [self.viewWeb loadHTMLString:errorString baseURL:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadWebView];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Sidebar Button Code
- (IBAction)searchBtn:(id)sender {
    
    [ScringoAgent openSidebar];
    
}

- (IBAction)shieldBtn:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
    
}

@end
