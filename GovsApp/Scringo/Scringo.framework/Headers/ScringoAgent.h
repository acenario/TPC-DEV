//
//  ScringoAgent.h
//  ScringoExample2
//
//  Created by Ofer Kalisky on 1/10/12.
//  Copyright (c) 2012 Ziggy Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#define kScringoNotificationActivityActionTapped        @"kScringoNotificationActivityActionTapped"
#define kScringoCustomButtonClicked                     @"kScringoCustomButtonClicked"
#define kNotificationScringoIsReady                     @"ScringoIsReady"

@class Facebook;

typedef enum {
    SCRINGO_BUTTON1,
    SCRINGO_BUTTON2,
    SCRINGO_BUTTON3,
    SCRINGO_BUTTON4,
} ScringoActivationButtonType;

@protocol ScringoImageFetcher;

@protocol ScringoImageFetcherDelegate <NSObject>
-(void)imageFetcherDidFinish:(id<ScringoImageFetcher>)imageFetcher withImage:(UIImage *)image;
-(void)imageFetcherGotError:(id<ScringoImageFetcher>)imageFetcher withError:(NSError *)error;
-(NSString *)imageFetcherDelegateId;
@end

@protocol ScringoImageFetcher <NSObject>
-(BOOL)fetchImage:(NSString *)imageLocation withDelegate:(id<ScringoImageFetcherDelegate>)delegate;
-(void)cancelDelegate:(id<ScringoImageFetcherDelegate>)delegate;
-(BOOL)shouldEnableImageShare:(NSString *)imageLocation;
-(NSString *)shareUrlForImage:(NSString *)imageLocation;
@end

@interface ScringoAgent : NSObject {

}

+(void)startSession:(NSString *)appId locationManager:(CLLocationManager *)locationManager;
+(void)startSession:(NSString *)appId locationManager:(CLLocationManager *)locationManager withDelay:(float)delay;
+(void)setTestMode:(BOOL)testMode;

+(void)postToFeed:(NSString *)feedMessage;
+(void)postToFeed:(NSString *)feedMessage withLink:(NSString *)link;
+(void)postToFeed:(NSString *)feedMessage withImage:(NSString *)imageUrl withDescription:(NSString *)description withSubDesc:(NSString *)subDesc withActionVerb:(NSString *)actionVerb withActionId:(NSString *)actionId;

+(void)didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+(void)didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
+(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

+(BOOL) handleOpenURL:(NSURL *)url;
+(BOOL) handleOpenURL:(NSURL *)url withFacebook:(Facebook *)appFacebook;

// Some utility function that Scringo provides
+(void) postToFacebookWall:(NSMutableDictionary *)params;

+(void)setScringoActivationButtonType:(ScringoActivationButtonType)buttonType;
+(UIBarButtonItem *)scringoActivationBarItem;
+(UIButton *)scringoActivationButtonOpensToLeft:(BOOL)opensToLeft;

+(void)openSidebar;
+(void)closeSidebar;

+(void)pauseSwipe;
+(void)resumeSwipe;
+(BOOL)isSwipeEnalbed;

+(BOOL)isPopInAdsEnabled;
+(void)showPopInAdNow;
+(void)disablePopInAds:(BOOL)disablePopInAds;
+(void)disableSideBarAds:(BOOL)disableSideBarAds;

+(void)setCustomImageFetcher:(id<ScringoImageFetcher>)customImageFetcher;

@end
