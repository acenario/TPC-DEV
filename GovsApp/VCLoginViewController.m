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

- (void)viewDidLoad
{
    [super viewDidLoad];
    contentArray = [NSArray arrayWithContentsOfFile:[self dataFilePath]];
    
    NSString *success = [contentArray objectAtIndex:0];
    NSString *username = [contentArray objectAtIndex:1];
    
    if ([success isEqualToString:@"success"]) {
        usernameField.text = username;
        
    } 
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)login:(id)sender {

   
    
    NSString *enteredUsername = usernameField.text;
    NSString *enteredPassword = passwordField.text;
    
    //NSString *escapedUsername = [enteredUsername stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.gda:phevarE3r@portals.veracross.com/gda/authenticate?username=%@&password=%@",enteredUsername,enteredPassword];
    
    
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSError *error;
    
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    
    
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        
    }
    
    NSData *data = [resultString dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:data];//init NSXMLParser with receivedXMLData
    [xmlParser setDelegate:self]; // Set delegate for NSXMLParser
    [xmlParser parse];
    
    
    //NSLog(@"Data: %@", resultString);
    
    
    
}

- (IBAction)exit:(id)sender {

    [self dismissModalViewControllerAnimated:YES];

}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    [SVProgressHUD showWithStatus:@"Connecting to Veracross..."];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
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
        [self dismissModalViewControllerAnimated:YES];
        
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