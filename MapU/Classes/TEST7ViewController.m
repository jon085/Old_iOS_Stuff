//
//  TEST7ViewController.m
//  TEST7
//
//  Created by jono on 2012/08/06.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

///////////////////////////
//////THESE 3 LINES WILL OPEN A NEW VIEW ON THE SCREEN////////
//  SecondView *tmpView = [[SecondView alloc] initWithNibName:nil bundle:nil];
//  [self presentModalViewController:tmpView animated:YES];
//  [tmpView release];
//////////////////////////


#import "TEST7ViewController.h"
#import "EMailAssistant.h"
//#import "PlaceMark.h"
#import "SecondView.h"

@implementation TEST7ViewController

@synthesize mapView;
@synthesize emailAddress;
//@synthesize textField;
@synthesize label;
@synthesize callNumber;
@synthesize curLocation;

@synthesize curLocPlaceMark;
@synthesize selMapMethod;

@synthesize tgr;
@synthesize lpr;
@synthesize pin;
@synthesize curPlacement;
@synthesize geoCoder;
//@synthesize SetToCurrentLocation;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

//-(void) SetToCurrentLocation:(id)sender{
//	NSLog(@"Set To Current Location...");	
//}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	geoCoderResponded = NO;
	
	
	//curLocation = [[CLLocation alloc] init];	
	
//	  textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	  emailAddress.clearButtonMode = UITextFieldViewModeWhileEditing;

	[mapView setMapType:MKMapTypeSatellite];

	//UIGestureRecognizer *gestureRec = [[UIGestureRecognizer alloc] init];
//	gestureRec.delegate = self;
//	mapView.userInteractionEnabled = YES;
//
//	[mapView addGestureRecognizer:gestureRec];
	
//	tgr =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
//	tgr.numberOfTapsRequired = 1;
//	tgr.numberOfTouchesRequired = 1;

	
//	[mapView addGestureRecognizer:tgr];
//	[tgr release];
	
	
	lpr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	
	[mapView addGestureRecognizer:lpr];
	
    [super viewDidLoad];
}



- (void) handleGesture:(UIGestureRecognizer *) gestureRecognizer {
	NSLog(@"Gesture Handler Called...");
		
	if (gestureRecognizer.state != UIGestureRecognizerStateEnded)
		return;	
	
	if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
	
	CGPoint touchPoint = [gestureRecognizer locationInView:mapView];
		
	PointToSend = [mapView convertPoint:touchPoint toCoordinateFromView:mapView];

	NSLog(@"Touched at: %.3f, %.3f", PointToSend.latitude, PointToSend.longitude);
	
	NSLog(@"Touched MAP...");
	
	
		
//	PlaceMark *curPlacement = [[[PlaceMark alloc] initWithCoordinate:PointToSend] autorelease];
		
			//PlaceMark *curPlacement = [[PlaceMark alloc] initWithCoordinate:PointToSend];
	
		
		
	[curPlacement setTitle:@"New Location"];
		NSString *NSS = [NSString stringWithFormat:@"Chosen Point\n%.3f, %.3f", PointToSend.latitude, PointToSend.longitude];
		
		
		
		//[geoCoder initWithCoordinate:PointToSend];
//		geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:PointToSend];
		
		//  geoCoder.delegate = self;
		
		if (!geoCoderResponded){
			geoCoderResponded = YES;
		  geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:PointToSend];
			geoCoder.delegate = self;
		  [geoCoder start];
		}
		
		
		NSLog(@"Past Start GEO");
		
	[curPlacement setSubtitle:NSS];
		[curPlacement setCoordinate:PointToSend];
	
//	for (PlaceMark *pm in mapView.annotations) { //My way is better... to remove matching PlaceMark classes
//		[mapView removeAnnotation:pm];
//	}
	
//	[mapView removeGestureRecognizer:tgr]; //???

//		if ([mapView.annotations objectAtIndex:0] != nil){
//		  [mapView removeAnnotation:[mapView.annotations objectAtIndex:0]];
//		}
//	[mapView addAnnotation:curPlacement]; //Add it with Title
		
//		[[mapView.annotations objectAtIndex:0] setAnnotation:curPlacement];
//				[[mapView.annotations objectAtIndex:0] setSubTitle:curPlacement.subtitle];
//		
//		[[mapView.annotations objectAtIndex:0] setTitle:curPlacement.title];
//		[[mapView.annotations objectAtIndex:0] setSubtitle:curPlacement.subtitle];
//		[[mapView.annotations objectAtIndex:0] setCoordinate:curPlacement.coordinate];
	}
}


- (void) viewWillAppear:(BOOL)animated {
	NSLog(@"VIEW WILL APPEAR called");
	
[[NSNotificationCenter defaultCenter] addObserver:self
										 selector:@selector(keyboardWillShow:)
											 name:UIKeyboardWillShowNotification
										   object:self.view.window];

	
//	UIPanGestureRecognizer *mapPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:selector(panDone:)];

//	UIPanGestureRecognizer *mapPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDone:)];
//	[self.mapView addGestureRecognizer:mapPanGesture];
//	UIPinchGestureRecognizer *mapPinchGesture = [[UIPinchGestureRecognizer alloc]  initWithTarget:self action:@selector(panDone:)];
//	[self.mapView addGestureRecognizer:mapPinchGesture];
		
	geoCoder = [[MKReverseGeocoder alloc] init];
	
	if (!HasRun) {
	
	   curLocation = [[CLLocationManager alloc] init];
	
	[curLocation setDelegate:self];
	[curLocation setDesiredAccuracy:kCLLocationAccuracyBest];

	   [curLocation startUpdatingLocation];
	
	}
	
	[super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];	
	[super viewWillDisappear:animated];
}

- (void) panDone:(UIPanGestureRecognizer *)panRecognized{
	//CGPoint TRANS = [panRecognized CGPointValue];
	
	NSLog(@"Panned it!");
}


- (void) keyboardWillShow: (NSNotification *)notif {
	NSLog(@"Keyboard Will SHOW");
//	NSDictionary* info = [notif userInfo];
//	
//	NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
//	
//	CGSize keyboardSize = [aValue CGRectValue].size;
//	
//	float bottomPoint;
//	
////	if ([textField isFirstResponder]){
////	  //bottomPoint = (textField.frame.origin.y+textField.frame.size.height+10);
////		bottomPoint = 0;
////		[textField resignFirstResponder];
////	}
//	if ([emailAddress isFirstResponder]){
//		bottomPoint = (emailAddress.frame.origin.y+emailAddress.frame.size.height+10);
//	}	
//		
//	//scrollAmount = keyboardSize.height - (self.view.frame.size.height - bottomPoint);
//	
//	if (bottomPoint > [aValue CGRectValue].origin.y){
//	scrollAmount = self.view.frame.size.height - keyboardSize.height - bottomPoint;
//	
//	scrollAmount *= -1;
//	}
//	
//	
//	//scrollAmount = 50;
//	
//	//scrollAmount = textField.frame.size.height + 50;
//	
////	NSLog(@"textField Height = %d", textField.frame.size.height);
//	NSLog(@"Scroll Amount: %.2f", scrollAmount);
//	
//	if (scrollAmount > 0) {
//		moveViewUp = YES;
//		[self scrollTheView:moveViewUp];
//	}
//	else
//	{
//		moveViewUp = NO;
//	}
//	
//	
//	
//	
////	if ([textField isFirstResponder] || [emailAddress isFirstResponder]){
////	moveViewUp = YES;
////	[self scrollTheView:moveViewUp];
////	}
//	
}

- (void) scrollTheView:(BOOL)movedUp {
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.3];
	
	CGRect rect = self.view.frame;
	
	if (movedUp) {
		rect.origin.y -= scrollAmount;
	}else{
	    rect.origin.y += scrollAmount;
	}
	
	self.view.frame = rect;
	[UIView commitAnimations];
	
}

- (BOOL) textFieldShouldReturn: (UITextField *) theTextField {
	NSLog(@"textField Should Return");
	[theTextField resignFirstResponder];
//	if (moveViewUp) {
//		[self scrollTheView:NO];
//	}
//		[self updateCallNumber];
	
	return YES;
}


-(void) updateCallNumber {
//	self.callNumber = textField.text;
//	label.text = self.callNumber;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	NSLog(@"Map Touch > %@",[event touchesForView:mapView].accessibilityTraits);
	NSLog(@"EmailText > %@",[event touchesForView:emailAddress].accessibilityTraits);
	
	
//	[textField resignFirstResponder];
	[emailAddress resignFirstResponder];
	
	if ([mapView isFirstResponder]){
		NSLog(@"MapView Touched!");	
		//[textField resignFirstResponder];
		[emailAddress resignFirstResponder];
	}
	
//	if ( textField.editing) {
//		NSLog(@"Is On TextField now");
//		[textField resignFirstResponder];
//		[self updateCallNumber];
//		if (moveViewUp) {
//			[self scrollTheView:NO];
//		}
//	}

	
	if ( emailAddress.editing) {
		NSLog(@"Is On EMAILField now");
		[emailAddress resignFirstResponder];
		[self updateCallNumber];
		if (moveViewUp) {
			[self scrollTheView:NO];
		}

	}
	
	[super touchesBegan:touches withEvent:event];
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


- (void)dealloc {
	
  	    [emailAddress release];
		//[textField release];
		[label release];
		[callNumber release];
		[curLocation release];
		[mapView release];
	    [tgr release];
	    [pin release];
		[curPlacement release];
//		[geoCoder release];
	
    [super dealloc];
}


- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {

	[curLocation stopUpdatingLocation];
	
//	textField.text = [NSString stringWithFormat:@"Error: %@", [error localizedDescription]];
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Obtain Location Failed" message:@"System failed to obtain your current location, Retry or Cancel" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
	alert.tag = 123;
//	UIAlertView *alert = [[UIAlertView alloc] ini
	
	[alert show];
	
	[alert release];
	
	
	
    NSLog(@"Location Manager: Error - %@", [error localizedDescription]);
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123){
		NSLog(@"On ALERT 123! -> Pressed: %i", buttonIndex);
		if (buttonIndex == 1){
			[curLocation startUpdatingLocation];	
		}
		
	}
}


//Called when adding a pin to the map...
- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {

	//[mapView removeGestureRecognizer:lpr];

	NSLog(@"Adding an Annotation!");	

	pin = (MKPinAnnotationView *) [self.mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN1"];
	
	if (pin == nil) {
		pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PIN1"];
	}
	else
	{
		pin.annotation = annotation;
	}

		NSLog(@"P1");	
	
	
//	[pin setImage:[UIImage imageNamed:@"CrossHair.png"]];
	
	//[pin setSelected:TRUE];
//	[pin setDraggable:YES];
	pin.pinColor = MKPinAnnotationColorGreen;
	pin.animatesDrop = YES;      //Just a drop-in animation
	[pin setCanShowCallout:YES]; //Allows the callout box to display or disable callout box showing
	[pin setCalloutOffset:CGPointMake(-5,5)];
//	pin.image = [UIImage imageNamed:@"EYE.jpg"];
	
	//[mapView removeGestureRecognizer:self];
	
	
	NSLog(@"P2");	
	
	//Causes crash...
	[mapView selectAnnotation:annotation animated:YES]; //This makes the callout box appear/shows automatically. [If I do PIN, it gets stuck in an adding Pin Loophole]
	
	//[mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:YES];
	
	//[mapView addGestureRecognizer:lpr];
	
	curLocation = annotation;
	
	
	NSLog(@"P3");	
	
	return pin;
	
}


- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
	NSLog(@"Touches Ended");
	[emailAddress resignFirstResponder];
	//[textField resignFirstResponder];
}

//- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
//
//		MKPinAnnotationView *annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation
//																	reuseIdentifier:@"PIN11"];
//	annView.animatesDrop = TRUE;
//	annView.canShowCallout = YES;
//	[annView setSelected:YES];
//	annView.pinColor = MKPinAnnotationColorPurple;
//	annView.calloutOffset = CGPointMake(-5, 5);
//		
//	return annView;
//	
//	
//}

//Did find location of user
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
	NSLog(@"Did Update to location!");
	
	HasRun = YES;
	
	[curLocation stopUpdatingLocation]; //Stop searching for location, since it found it already... [Otherwise continuous updating occurs]

	//MKAnnotation PinPoint;

	//[curLocAnnotation 
//	curLocPlaceMark.coordinate = curLocation.location.coordinate;
//	[mapView addAnnotation:curLocPlaceMark];

//	 Pin *sel = [[Pin alloc] init];

	NSString *tLatitude  = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.latitude];
	NSString *tLongitude = [NSString stringWithFormat:@"%3.5f", newLocation.coordinate.longitude];

	
	PointToSend = newLocation.coordinate;
	
	[mapView setRegion:MKCoordinateRegionMake(newLocation.coordinate, MKCoordinateSpanMake(0.001, 0.001))];

//	[self AddMapAnnotation:newLocation.coordinate.latitude
//			  LongitudeSet:newLocation.coordinate.longitude
//					 Title:@"Your Location"
//				   SubText:[NSString stringWithFormat:@"%@, %@", tLatitude,tLongitude]];

	////////////////////////////////////////
	
	//Adding a Marker to the Found Location....
//	PlaceMark *curPlacement = [[[PlaceMark alloc] initWithCoordinate:newLocation.coordinate] autorelease];

	
	curPlacement = [[PlaceMark alloc] initWithCoordinate:newLocation.coordinate];
	
	  [curPlacement setTitle:@"You are Here"];
	  [curPlacement setSubTitle:@"This is your current Location"];

	
//	for (int i = 0; i < [mapView.annotations count]; i++) {                               //This will delete all Pins off map, if they are the same PlaceMark class...
//		if ([[mapView.annotations objectAtIndex:i] isKindOfClass:[PlaceMark class]]){
//			[mapView removeAnnotation:[mapView.annotations objectAtIndex:i]];
//		}
//	}
	
	for (PlaceMark *pm in mapView.annotations) { //My way is better... to remove matching PlaceMark classes
		[mapView removeAnnotation:pm];
	}
	
	
	if ([mapView.annotations count] == 0){
		
	[mapView addAnnotation:curPlacement]; //Add it with Title
	
	}else{
		
		[[mapView.annotations objectAtIndex:0] setTitle:curPlacement.title];
		[[mapView.annotations objectAtIndex:0] setSubtitle:curPlacement.subtitle];
		[[mapView.annotations objectAtIndex:0] setCoordinate:curPlacement.coordinate];
		
	}
		
	////////////////////////////////////////
	
//	textField.text = [NSString stringWithFormat:@"%@, %@", tLatitude, tLongitude];
	NSLog(@"Did Update to Location!");
}


- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	
	NSLog(@"calloutAccessoryControlTapped");
//	if ([emailAddress isFirstResponder] || [textField isFirstResponder]){
//	if ([emailAddress isFirstResponder]){
//		[emailAddress resignFirstResponder];
//		[textField resignFirstResponder];
//	}	
}

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
	NSLog(@"Selected Annnotation View...");	
	
	
//	//[mapView addGestureRecognizer:tgr];
//	
//	
//	//if ([emailAddress isFirstResponder] || [textField isFirstResponder]){
//	if ([emailAddress isFirstResponder]){
//		[emailAddress resignFirstResponder];
////		[textField resignFirstResponder];
//	}
//	
//	[view isSelected] ? NSLog(@"View IS Selected") : NSLog(@"View NOT Selected");
//	
//	if ([view isSelected]){
//		[view setSelected:![view isSelected]];
//		[view setCanShowCallout:![view isSelected]];
//	}
	
}

- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
	NSLog(@"Did Deselect Annotation View...");
	//[mapView removeGestureRecognizer:tgr];
}

- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(int)newState fromOldState:(int)oldState{
	
	NSLog(@"Changed Drag State..");
}

- (void) mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
	NSLog(@"Did ADD Annotation Views");
	
//	[mapView selectAnnotation:[mapView.annotations objectAtIndex:0] animated:NO];
	
}

- (void) PressTheButton:(id)sender {
	NSLog(@"Pressed a button");
	[sender resignFirstResponder];
	
	if ([sender tag] == 0){
//	 //////THESE 3 LINES WILL OPEN A NEW VIEW ON THE SCREEN////////
//	  SecondView *tmpView = [[SecondView alloc] initWithNibName:nil bundle:nil];
//	  [self presentModalViewController:tmpView animated:YES];
//	  [tmpView release];
		
		NSLog(@"PointToSend.latitude = %.3f",PointToSend.latitude);

		
//		EMailAssistant *es = [[EMailAssistant alloc] initWithNibName:nil bundle:nil];
		
			MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
			
			//es.mailComposer
			
			mail.mailComposeDelegate = self;
			
			if ([[NSString stringWithFormat:@"%.3f", PointToSend.latitude] isEqualToString:@"0.000"] == 0){
				
				if ([MFMailComposeViewController canSendMail]){
			 
				MFMailComposeViewController *mailComposer; 
				mailComposer  = [[MFMailComposeViewController alloc] init];
				mailComposer.mailComposeDelegate = self;
				
										
				[mailComposer setToRecipients:[NSArray arrayWithObjects:emailAddress.text, nil]];
				[mailComposer setSubject: @"Whoza"];
					
					NSString *strMsg;
					
					strMsg = @"Click the link below to see the location<br/>";
					strMsg = [strMsg stringByAppendingString: [self GeoStringBuilder:PointToSend RefName: curPlacement.subtitle]];
					
					
					
//				[mailComposer setMessageBody: [NSString stringWithFormat:@"Location is: %3.5f, %3.5f",
//											   //curLocation.location.coordinate.latitude, curLocation.location.coordinate.longitude]
//											   //[curLocation location].coordinate.latitude, [curLocation location].coordinate.longitude]
//											   PointToSend.latitude, PointToSend.longitude]
//											isHTML:NO];
					
					
//				[mailComposer setMessageBody: [NSString stringWithString:[self GeoStringBuilder:PointToSend RefName: curPlacement.subtitle]]
//										 isHTML:YES];

				[mailComposer setMessageBody: strMsg
									  isHTML:YES];
					
				[self presentModalViewController:mailComposer animated:YES];
				
				[mailComposer release];
				}
				else
				{
					NSLog(@"Can't Send Mail");
				}
		
			
			}else{
			 NSLog(@"Hasn't obtained Location yet");	
				//[es SendEmailTo:emailAddress.text MsgSubject:@"Location"
						//MsgBody:[NSString stringWithFormat:@"Your Current Location is: %3.5f, %3.5f",
		//						 26.063835, -38.04342]];
				 
		//		 MFMailComposeViewController *mailComposer; 
		//		 mailComposer  = [[MFMailComposeViewController alloc] init];
		//		 mailComposer.mailComposeDelegate = self;
		//
		//		[mailComposer setToRecipients:[NSArray arrayWithObjects:emailAddress.text, nil]];
		//		 [mailComposer setSubject: @"Location"];
		//		[mailComposer setMessageBody: [NSString stringWithFormat:@"Your Current Location is: %3.5f, %3.5f",
		//									   						 26.063835, -38.04342] isHTML:NO];
		//		 
		//		 [self presentModalViewController:mailComposer animated:YES];
		//		 
		//		 [mailComposer release];
				
			}
		
		
	}
	
//	if ([sender tag] == 1){ //This is the button for setting to your current location...
//	//	MKAnnotation *MKA2;
////		
////		
////		[mapView removeAnnotation:<#(id <MKAnnotation>)annotation#>
//		
//		[curLocation setDesiredAccuracy:kCLLocationAccuracyBest];
//		
//		[curLocation startUpdatingLocation];
//		
//	}
	
	//////////////////////////////////////////////////////////////
	

	
}

- (void) HIDEKB {
	[emailAddress resignFirstResponder];	
}

- (void) PressedBarMenuButton:(id) sender{
	NSLog(@"Bar Menu pressed");
	
	if ([sender tag] == 0) { //Butt Sel Curr Location
	//  [curLocation setDesiredAccuracy:kCLLocationAccuracyBest];
		curLocation = [[CLLocationManager alloc] init];
		
		[curLocation setDelegate:self];
		[curLocation setDesiredAccuracy:kCLLocationAccuracyBest];
		
		[curLocation startUpdatingLocation];
	}
}

- (void) ButtonSelMapMethod:(id)sender{
	NSLog(@"Selected Map Method: %i", selMapMethod.selectedSegmentIndex);	
	selMapMethod = sender;
	
	
	switch (selMapMethod.selectedSegmentIndex) {
		case 0:
				[mapView setMapType:MKMapTypeStandard];
			break;
		case 1:
				[mapView setMapType:MKMapTypeSatellite];
			break;
		case 2:
				[mapView setMapType:MKMapTypeHybrid];
			break;
	}
	
}

- (void) OpenContactsWindow{

//	  SecondView *tmpView = [[SecondView alloc] initWithNibName:nil bundle:nil];
//	  [self presentModalViewController:tmpView animated:YES];
//	  [tmpView release];
	
	ABPeoplePickerNavigationController *picker = [[ABPeoplePickerNavigationController alloc] init];
	
	picker.peoplePickerDelegate = self;
	
	[self presentModalViewController:picker animated:YES];
	
//	[self.view.window addSubview:tmpView.view];
	
	
	
//	UIBarButtonItem *backButt = [[UIBarButtonItem alloc] initWithTitle:@"Back"
//																 style:UIBarButtonItemStyleDone
//																target:nil
//																action:nil];
//
//	tmpView.navigationItem.backBarButtonItem = backButt;
//	//[[self navigationController] pushViewController:tmpView animated:YES];
	
	
	
//	[self presentModalViewController:tmpView animated:YES]; //This pops up the new window...
	
	//[backButt release];
//	[tmpView release], tmpView = nil;
	
	
	//[self.view addSubview:tmpView.view];
//	[window addSubview:tmpView.view];
	
}

//Called When leaving the Email window.
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissModalViewControllerAnimated:YES];
	
	if (result == MFMailComposeResultFailed){
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email Failed" message:@"Email Failed to Send" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}
}

//////////GEO LOCATOR FUNCTIONS///////////

-(void) reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
	geoCoderResponded = NO;
	
	NSLog(@"Reverse Geocoder Did Find Placemark!");

	
	[geoCoder cancel];
	[geoCoder release], geocoder = nil;
		
	NSString *tmpStr;
	
	NSString *strAddress = [placemark.addressDictionary objectForKey:(NSString *) kABPersonAddressStreetKey];
	
//	tmpStr = placemark.subThoroughfare;
//	tmpStr = [tmpStr stringByAppendingString:@" "];
//	tmpStr = [tmpStr stringByAppendingString: strAddress] ;
//	tmpStr = [tmpStr stringByAppendingString:@", "];
//	tmpStr = [tmpStr stringByAppendingString: [placemark.locality stringByAppendingFormat:@", "]];
//	tmpStr = [tmpStr stringByAppendingString: placemark.country];

	tmpStr = [self StringBuilder:placemark.subThoroughfare EXTRAS:@" "];
	tmpStr = [tmpStr stringByAppendingString: [self StringBuilder:strAddress EXTRAS:@", "]];
	tmpStr = [tmpStr stringByAppendingString: [self StringBuilder:placemark.locality EXTRAS:@", "]];
	tmpStr = [tmpStr stringByAppendingString: [self StringBuilder:placemark.country EXTRAS:@""]];
	[curPlacement setSubtitle:tmpStr];
}

- (NSString *) StringBuilder:(NSString *)strAdd EXTRAS:(NSString *) strExtra{
	NSString *tmpStr;
	tmpStr = @"";
	if ([strAdd length] >0 ) {
		tmpStr = strAdd;
		if ([strExtra length] >0 ) {
		  tmpStr = [tmpStr stringByAppendingString:strExtra];
		}
	}
	
	return tmpStr;
}

- (NSString *) GeoStringBuilder:(CLLocationCoordinate2D) coordinates RefName:(NSString *) strName{
	NSString *tmpStr;
//	tmpStr = @"";

    //tmpStr = @"<a href=\"geo:";
//	tmpStr = [tmpStr stringByAppendingString: [NSString stringWithFormat:@"%.6f,%.6f\">", coordinates.latitude, coordinates.longitude]];
//	tmpStr = [tmpStr stringByAppendingString:strName];
//	tmpStr = [tmpStr stringByAppendingString:@"</a>"];
	
    tmpStr = @"<a href=\"http://maps.google.com/maps?q=";
	tmpStr = [tmpStr stringByAppendingString: [NSString stringWithFormat:@"%.6f,%.6f\">", coordinates.latitude, coordinates.longitude]];
	tmpStr = [tmpStr stringByAppendingString:strName];
	tmpStr = [tmpStr stringByAppendingString:@"</a>"];
	
	
	return tmpStr;
}

- (void) reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
	geoCoderResponded = NO;
	
	NSLog(@"123");
	NSLog(@"Reverse Geocoder had 3rr0r: %@", [error localizedDescription]);	
	
	//[geoCoder cancel];
	[geoCoder release], geocoder = nil;
}

///////////////CONTACTS HANDLERS///////////////////

- (void) peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    [self dismissModalViewControllerAnimated:YES];	
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
      //__bridge_transfer
	NSLog(@"Picked 1 ?!");
	
	NSString *PersonName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
	NSString *PersonSurname = ABRecordCopyValue(person, kABPersonLastNameProperty);
	NSString *PersonEmailAddress = nil; //ABRecordCopyValue(person, kABPersonEmailProperty);
	NSString *PersonPhoneNumber = nil;
	
	
	ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
	
	ABMultiValueRef emailaddresses = ABRecordCopyValue(person, kABPersonEmailProperty);
	
	
	if (ABMultiValueGetCount(phoneNumbers) > 0) {
		PersonPhoneNumber = (NSString *) ABMultiValueCopyValueAtIndex(phoneNumbers, 0);
	} else {
		PersonPhoneNumber = @"[None]";
	}
	
	if (ABMultiValueGetCount(emailaddresses) > 0) {
		PersonEmailAddress = (NSString *) ABMultiValueCopyValueAtIndex(emailaddresses, 0);
		
	} else {
		PersonEmailAddress = @"[None]";
	}
	
       
	   
	   [self dismissModalViewControllerAnimated:YES];
	
	emailAddress.text = PersonEmailAddress;
}

- (BOOL) peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
	NSLog(@"Picked 2 ?!");
}

@end
