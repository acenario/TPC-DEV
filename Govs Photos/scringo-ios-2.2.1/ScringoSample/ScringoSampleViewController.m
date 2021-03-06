//
//  ScringoSampleViewController.m
//  ScringoSample
//
//  Created by Guy Federovsky on 03/03/13.
//  Copyright (c) 2013 Scringo. All rights reserved.
//

#import "ScringoSampleViewController.h"
#import <Scringo/ScringoAgent.h>

#define kScringoSampleAppRiverImageUrl @"http://ichef.bbci.co.uk/naturelibrary/images/ic/credit/640x395/r/ri/river/river_1.jpg"
#define kScringoSampleAppRiverFeedImageUrl @"http://drewhaninger.com/wp-content/uploads/2012/09/Papua-New-Guinea-menya-river_may12_1600.jpg"

@interface ScringoSampleViewController ()
-(void)viewActivity:(NSNotification *)aNotification;
-(void)customFeatureClicked:(NSNotification *)aNotification;
-(void)closeWebView;
@end

@implementation ScringoSampleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:kScringoSampleAppRiverImageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [_riverImage setImage:img];

    [_riverLikeButton updateLikeObject:kScringoSampleAppRiverImageUrl type:SCRINGO_APP_LIKE_IMAGE description:@"A River"];
    _navBar.topItem.leftBarButtonItem = [ScringoAgent scringoActivationBarItem];

    UIButton *scringo = [ScringoAgent scringoActivationButtonOpensToLeft:NO];
    scringo.frame = CGRectMake(0, 260, 60, 60);

    [self.view addSubview:scringo];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewActivity:) name:kScringoNotificationActivityActionTapped  object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customFeatureClicked:) name:kScringoCustomButtonClicked object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_riverImage release];
    [_riverLikeButton release];
    [_navBar release];
    [super dealloc];
}

- (IBAction)addRiverFeed:(id)sender {
    [ScringoAgent postToFeed:@"Yet another very nice river" withImage:kScringoSampleAppRiverFeedImageUrl withDescription:@"Menya River" withSubDesc:@"In Papua New Guinea" withActionVerb:@"View" withActionId:kScringoSampleAppRiverFeedImageUrl];
}

-(void)viewActivity:(NSNotification *)aNotification {
    NSLog(@"got notification userInfo=%@", [aNotification userInfo]);

    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
    NSString *url = [[aNotification userInfo] valueForKey:@"action"];
    NSURLRequest *request = [[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]] autorelease];
    [webView setScalesPageToFit:YES];
    CGRect frame = webView.frame;
    frame.origin.y = _navBar.frame.size.height;
    frame.size.height = [UIApplication sharedApplication].keyWindow.frame.size.height - _navBar.frame.size.height;
    webView.frame = frame;
    [webView loadRequest:request];
    webView.tag = 9090;
    [self.view addSubview:webView];

    CGRect mainViewFrame = [UIApplication sharedApplication].keyWindow.frame;
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    frame = CGRectMake(0, 0, 60, 30);
    frame.origin.x = (mainViewFrame.size.width - frame.size.width) / 2;
    frame.origin.y = mainViewFrame.size.height - (frame.size.height * 2);
    closeButton.frame = frame;
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    closeButton.tag = 9091;
    [self.view addSubview:closeButton];
}

-(void)closeWebView {
    UIView *w = [self.view viewWithTag:9090];
    [w removeFromSuperview];
    
    w = [self.view viewWithTag:9091];
    [w removeFromSuperview];
    
    w = [self.view viewWithTag:9092];
    [w removeFromSuperview];
}

-(void)customFeatureClicked:(NSNotification *)aNotification {
    NSString *featureId = [[aNotification userInfo] valueForKey:@"customButtonId"];
    NSLog(@"custom Feature Clicked; featureId=%@", featureId);

    CGRect frame = [UIApplication sharedApplication].keyWindow.frame;
    frame.origin.y = _navBar.frame.size.height;
    frame.size.height -= _navBar.frame.size.height;
    UIView *view = [[UIView alloc] initWithFrame:frame];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view setOpaque:YES];
    view.tag = 9090;
    [self.view addSubview:view];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2 - 50, frame.size.width, 100)];
    [label setText:[NSString stringWithFormat:@"This view was opened as an implementation example of clicking the optional custom button (with Id '%@') in Scringo menu", featureId]];
    [label setTextColor:[UIColor purpleColor]];
    [label setNumberOfLines:0];
    [label setLineBreakMode:NSLineBreakByWordWrapping];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.tag = 9092;
    [self.view addSubview:label];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    frame = CGRectMake(0, 0, 60, 30);
    frame.origin.x = (view.frame.size.width - frame.size.width) / 2;
    frame.origin.y = view.frame.size.height - (frame.size.height * 2);
    closeButton.frame = frame;
    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeWebView) forControlEvents:UIControlEventTouchUpInside];
    [closeButton setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    closeButton.tag = 9091;
    [self.view addSubview:closeButton];

    [ScringoAgent closeSidebar];
}

@end
