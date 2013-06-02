//
//  VCLoginViewController.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 4/16/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "VCLoginViewController.h"

@interface VCLoginViewController ()

@end

@implementation VCLoginViewController {
    NSMutableString *currentString;
    NSMutableArray *elementsArray;
    NSMutableArray *contentArray;
    CGPoint originalCenter;
    
}

@synthesize usernameField;
@synthesize passwordField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         
    }
    return self;
}


- (NSString *)documentsDirectory
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return documentsDirectory;
}

- (NSString *)dataFilePath
{
    return [[self documentsDirectory] stringByAppendingPathComponent:
            @"Milestone.plist"];
    
}

- (void) hideKeyboard {
    [self.view endEditing:YES];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.view.center = originalCenter;
    [UIView commitAnimations];
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    //NSLog(@"The x-coordinate is: %f and the y-coordinate is %f", originalCenter.x, originalCenter.y);
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.25];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    

    
    if (IS_IPHONE5) {
        //NSLog(@"iPhone 5");
        self.view.center = CGPointMake(originalCenter.x, 90);
    } else {
        //NSLog(@"iphone 4s or lower");
        self.view.center = CGPointMake(originalCenter.x, 45);
    }
    [UIView commitAnimations];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //[usernameField becomeFirstResponder];
    //[passwordField becomeFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.usernameField) {
        [self.passwordField becomeFirstResponder];
    }
    else if (textField == self.passwordField) {
        [self login:nil];
    }
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray = [NSArray arrayWithContentsOfFile:[self dataFilePath]];
    
    NSString *success = [contentArray objectAtIndex:0];
    NSString *username = [contentArray objectAtIndex:1];
    
    if ([success isEqualToString:@"success"]) {
        usernameField.text = username;
        
    }
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];

   
    originalCenter = CGPointMake(self.view.center.x, self.view.center.y);
    
    usernameField.delegate = self;
    passwordField.delegate = self;
    
    [ScringoAgent closeSidebar];


}

- (NSUInteger) supportedInterfaceOrientations {
    
    return UIInterfaceOrientationMaskPortrait;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)login:(id)sender {
    
    [SVProgressHUD showWithStatus:@"Connecting to Veracross..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
   
    
    NSString *enteredUsername = usernameField.text;
    NSString *enteredPassword = passwordField.text;
    
    //NSString *escapedUsername = [enteredUsername stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@portals.veracross.com/gda/authenticate?username=%@&password=%@",enteredUsername,enteredPassword];
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSError *error;
    
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    
    
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        //[self showNetworkError];
        
    }
    
    NSData *data = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:data];//init NSXMLParser with receivedXMLData
    [xmlParser setDelegate:self]; // Set delegate for NSXMLParser
    [xmlParser parse];
    
    
    //NSLog(@"Data: %@", resultString);
    
    
    
}

- (IBAction)exit:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
    

}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    //[SVProgressHUD showWithStatus:@"Connecting to Veracross..."];
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    elementsArray = [[NSMutableArray alloc] init];
    
}

//store all found characters between elements in currentString mutable string
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    string =[string stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    string =[string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    if(!currentString)
    {
        currentString = [[NSMutableString alloc] init];
    }
    
    [currentString appendString:string];
}

//When end of XML tag is found this method gets notified
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if([elementName isEqualToString:@"status"])
    {
        [elementsArray addObject:currentString];
        currentString=nil;
        return;
    }
    if([elementName isEqualToString:@"username"])
    {
        [elementsArray addObject:currentString];
        currentString=nil;
        return;
    }
    if([elementName isEqualToString:@"person_pk"])
    {
        [elementsArray addObject:currentString];
        currentString=nil;
        return;
    }
    /*if([elementName isEqualToString:@"token"])
    {
        [elementsArray addObject:currentString];
        currentString=nil;
        return;
    }*/
    
    currentString =nil;
}

//Parsing has ended
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    
    
    NSLog(@"Content of Elements Array: %@",elementsArray);
    NSString *success = [elementsArray objectAtIndex:0];
    
    if ([success isEqualToString:@"fail"]) {
        
        NSLog(@"Failed!!!");
        [SVProgressHUD showErrorWithStatus:@"Incorrect Login!"];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    }
    
    if ([success isEqualToString:@"success"]) {
        
        [elementsArray writeToFile:[self dataFilePath] atomically:YES];
        NSLog(@"Success!!!");
        [SVProgressHUD dismiss];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.25];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.view.center = originalCenter;
        [UIView commitAnimations];
        
        [self dismissViewControllerAnimated:YES completion:NULL];
        
    }
    
    
    elementsArray=nil;
    
    
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    NSLog(@"Error");
    [SVProgressHUD showErrorWithStatus:@"Check your connection!"];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



- (void)viewDidUnload {
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
}
@end
