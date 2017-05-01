//
//  JonStreetViewTSTViewController.h
//  JonStreetViewTST
//
//  Created by jono on 2012/08/28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleStreetViewAPI.h"
#import "GoogleStreetViewAPIDelegate.h"

@interface JonStreetViewTSTViewController : UIViewController <GoogleStreetViewAPIDelegate> {
    IBOutlet UIImageView*  streetViewImageView;
    IBOutlet UIActivityIndicatorView* activityIndicatorView;
    GoogleStreetViewAPI* api;
	
	IBOutlet UISlider *SLIDER;
	IBOutlet UILabel *LABEL;
	
	int ANGLE;
	
	CGPoint scrollStart;
	CGPoint scrollEnd;
	
	
	UIPanGestureRecognizer *imgPanGesture;
}

@property (nonatomic, retain) UIImageView* streetViewImageView;
@property (nonatomic, retain) UIActivityIndicatorView* activityIndicatorView;
@property (nonatomic, retain) IBOutlet UISlider *SLIDER;
@property (nonatomic, retain) IBOutlet UILabel *LABEL;

- (IBAction) buttonGetImage;
- (IBAction) sliderChanger;

@end

