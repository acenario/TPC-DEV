//
//  ContactInfoViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 2/28/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "ContactInfoViewController.h"

@interface ContactInfoViewController ()

@end

@implementation ContactInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)loadWebView {
    
    self.viewWeb.delegate = self;
    //[SVProgressHUD showWithStatus:@"Loading Content" maskType:SVProgressHUDMaskTypeGradient];
    NSString *fullURL = @"https://maps.google.com/?q=The+Governor's+Academy";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    [_viewMap loadRequest:requestObj];
    
    //[SVProgressHUD showSuccessWithStatus:@"Success!"];
    
    [self.viewWeb loadHTMLString:@"<html><body><center><h3><a href='tel:978-465-1763'>978.465.1763</a></h3></center></body></html>" baseURL:nil];
    [self.viewAdmissions loadHTMLString:@"<html><body><center><h3><a href='tel:978-499-3120'>978.499.3120</a></h3></center></body></html>" baseURL:nil];
    [self.viewHealth loadHTMLString:@"<html><body><center><h3><a href='tel:978-499-3126'>978.499.3126</a></h3></center></body></html>" baseURL:nil];
    [self.viewSecurity loadHTMLString:@"<html><body><center><h3><a href='tel:978-621-2784'>975.621.2784</a></h3></center></body></html>" baseURL:nil];
    [self.viewAddress loadHTMLString:@"<html><body><center><h4><a href='http://maps.apple.com/?q=The+Governor's+Academy'>1 Elm Street, Byfield MA 01922</a></h4></center></body></html>" baseURL:nil];
    
}

/*
 [self.viewWeb loadHTMLString:@"<html><center><a href='tel:1-408-555-5555'>1-408-555-5555</a></center></html>" baseURL:nil]; -- Call code
 [self.viewWeb loadHTMLString:@"<html><center><a href='http://maps.apple.com/?q=The+Governor's+Academy'>1-408-555-5555</a></center></html>" baseURL:nil];
 
 
 */

-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
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



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
