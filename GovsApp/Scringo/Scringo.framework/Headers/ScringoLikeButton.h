//
//  ScringoLikeButton.h
//  ScringoExample3
//
//  Created by Ofer Kalisky on 1/8/13.
//  Copyright (c) 2013 Ziggy Software. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SCRINGO_APP_LIKE_NONE,
    SCRINGO_APP_LIKE_IMAGE,
    SCRINGO_APP_LIKE_VIDEO,
    SCRINGO_APP_LIKE_POST,
    SCRINGO_APP_LIKE_OTHER
}  ScringoAppLikeObjectType;


@class ScringoLikeObject;
@class ScringoFeedMessage;
@class ScringoChatRoomsComment;
@class ScringoChatRoomsTopic;

@protocol ScringoLikeButtonDelegate
-(void)likeButtonStateChanged:(ScringoLikeObject *)likeObject toMode:(BOOL)mode;
@end

@interface ScringoLikeButton : UIButton {
    IBOutlet UIView *topLevelView;
    IBOutlet UIButton *likeOnButton;
    IBOutlet UIButton *likeOffButton;
    
    ScringoLikeObject *likeObject;
    BOOL likeObjectIsReady;
}

@property (nonatomic, assign) id<ScringoLikeButtonDelegate> delegate;
@property (nonatomic, retain) IBOutlet UIView *topLevelView;
@property (nonatomic, retain) IBOutlet UIButton *likeOnButton;
@property (nonatomic, retain) IBOutlet UIButton *likeOffButton;
@property (nonatomic, retain) ScringoLikeObject *likeObject;

-(IBAction)likeOnTapped:(id)sender;
-(IBAction)likeOffTapped:(id)sender;
-(void)updateLikeObject:(ScringoLikeObject *)aLikeObject;
-(void)updateLikeObjectFromFeed:(ScringoFeedMessage *)aFeedMessage;
-(void)updateLikeObjectFromChatRoomsWithComment:(ScringoChatRoomsComment *)aChatRoomsComment;
-(void)updateLikeObjectFromChatRoomsWithTopic:(ScringoChatRoomsTopic *)aChatRoomsTopic;
-(void)updateLikeObject:(NSString *)data type:(ScringoAppLikeObjectType)type description:(NSString *)description;

@end
