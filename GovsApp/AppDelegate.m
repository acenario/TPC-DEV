//
//  AppDelegate.m
//  GovsApp
//
//  Created by Arjun Bhatnagar on 1/15/13.
//  Copyright (c) 2013 The Productions Club. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h>
#import <Scringo/ScringoAgent.h>



@implementation AppDelegate

- (void)customizeAppearance
{
    UIImage *barImage = [UIImage imageNamed:@"navbar2"];
    [[UISearchBar appearance] setBackgroundImage:barImage];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar2.png"] forBarMetrics:UIBarMetricsDefault];
    

    
    /*[[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbar2.png"] forBarMetrics:UIBarMetricsLandscapePhone];*/
}




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [Parse setApplicationId:@"t7rMlEolr6pOza7fd90EsIy8sesRg8jC5kKiMuh7"
                  clientKey:@"K3d8MExfCXwiVSlXznxGmKqil6KMLIEfy8SV4TJ4"];
    [ScringoAgent startSession:@"qpzkhT0ZKFr8RZHfr4mOWuPAWX2mlhXI" locationManager:nil];
    //[ScringoAgent startSession:@"qpzkhT0ZKFr8RZHfr4mOWuPAWX2mlhXI" locationManager:nil withDelay:5.00];
    [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [self customizeAppearance];
    
    
    
    
    
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [ScringoAgent didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [ScringoAgent didFailToRegisterForRemoteNotificationsWithError:error];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [ScringoAgent didReceiveRemoteNotification:userInfo];
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ScringoAgent handleOpenURL:url];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"didReceiveLocalNotification %@", notification);
    
    //self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Departments"];
    
}

/*- (void)saveData
{
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    UINavigationController *navigationController = (UINavigationController *)[tabBarController.viewControllers objectAtIndex:0];
    AllListsViewController *controller = (AllListsViewController *)[navigationController.viewControllers objectAtIndex:0];
    [controller.dataModel saveChecklists];
    
}*/




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{

    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
}

@end
