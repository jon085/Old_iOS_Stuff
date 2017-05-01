//
//  JonStreetViewTSTViewController.m
//  JonStreetViewTST
//
//  Created by jono on 2012/08/28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "JonStreetViewTSTViewController.h"

@implementation JonStreetViewTSTViewController

@synthesize streetViewImageView;
@synthesize activityIndicatorView;
@synthesize SLIDER;
@synthesize LABEL;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	api = [[GoogleStreetViewAPI alloc] initWithImageWidth:240 imageHeight:240 usingSensor:NO];
    api.delegate = self;
	// Do any additional setup after loading the view, typically from a nib.
	
	imgPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(PanImageChecker:)];
	[imgPanGesture setMinimumNumberOfTouches:1];
	[imgPanGesture setMaximumNumberOfTouches:1];
	[imgPanGesture setDelegate:self];
	[streetViewImageView addGestureRecognizer:imgPanGesture];
	//[imgPanGesture release];
}


- (void) PanImageChecker: (UIPanGestureRecognizer *) gesture{
	//NSLog(@"GestureStateID = %i", [gesture state]);
	
//	if ([gesture state] == UIGestureRecognizerStateBegan || [gesture state] == UIGestureRecognizerStateChanged) {
//	  
//		NSLog(@"Pan Image!!");
//		
//	}
	
	//UIView *mv = streetViewImageView;
	//
//	CGPoint t = [gesture translationInView:[mv superview]];
//	NSLog(@"%.2f", t.x);
	
	if ([gesture state] == UIGestureRecognizerStateBegan){
		NSLog(@"Gesture Started");
		scrollStart = [gesture translationInView:streetViewImageView];
		
	}
	if ([gesture state] == UIGestureRecognizerStateEnded){
		NSLog(@"Gesture Ended");
		scrollEnd = [gesture translationInView:streetViewImageView];
		
//		NSLog(@"X1 = %.2f", (scrollStart.x));
//		NSLog(@"X2 = %.2f", (scrollEnd.x));
//		
//		NSLog(@"Distance Travelled = %.2f", ((scrollStart.x - scrollEnd.x)/3));
		
		
		ANGLE += (scrollStart.x - scrollEnd.x)/3;
		
		if (ANGLE > 360){
			ANGLE = ANGLE-360;
		}
		if (ANGLE < 0){
			ANGLE  = 360 - (ANGLE *= -1);	
		}
		
		//////////////
		  double latitude = -26.052684;
		  double longitude = 28.024211;
		  [api requestForStreetViewAtLatitude:latitude longitude:longitude heading:ANGLE fov:180 pitch:0];
		//////////////
	}
	
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void) buttonGetImage {
	double latitude = -26.052684;
    double longitude = 28.024211;
    [api requestForStreetViewAtLatitude:latitude longitude:longitude heading:ANGLE fov:180 pitch:0];
}


- (void)api:(GoogleStreetViewAPI *)api didReturnStreetViewImage:(UIImage *)image {
    dispatch_async(dispatch_get_main_queue(), ^{
		NSLog(@"Did Return Street View Image");
		
        self.streetViewImageView.image = image;
    });
    
}

- (void)api:(GoogleStreetViewAPI *)api failedReturnStreetViewImageWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
		NSLog(@"Failed Return Street View Image With Error");
		NSLog(@"Error: %@", [error description]);
		
//        [self.activityIndicatorView stopAnimating];
//        self.activityIndicatorView.hidden = YES;
        NSString* errorMessage = [NSHTTPURLResponse localizedStringForStatusCode:error.code];
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    });
}

- (void) sliderChanger {
	LABEL.text = [NSString stringWithFormat:@"Angle: %.1f", [SLIDER value]];
	ANGLE = [SLIDER value];
}

- (void)dealloc {
    [streetViewImageView release];
    [activityIndicatorView release];
	[SLIDER release];
	[LABEL release];
    [api release];
}

@end
