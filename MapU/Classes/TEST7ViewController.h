//
//  TEST7ViewController.h
//  TEST7
//
//  Created by jono on 2012/08/06.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "PlaceMark.h"

#import <AddressBookUI/AddressBookUI.h>

@interface TEST7ViewController : UIViewController 
								<UITextFieldDelegate, MKMapViewDelegate, UIAlertViewDelegate, UIGestureRecognizerDelegate,
								CLLocationManagerDelegate, MFMailComposeViewControllerDelegate, MKAnnotation,
								ABPeoplePickerNavigationControllerDelegate, MKReverseGeocoderDelegate>
{
	
	MKReverseGeocoder *geoCoder;
	
	
	CLLocationManager *curLocation;
	MKAnnotationView *curLocAnnotation;
	MKPlacemark *curLocPlaceMark;
	
	CLLocationCoordinate2D PointToSend;
	
//	IBAction UIButton *sendMessage;

	IBOutlet UITextField *emailAddress;
	
//	IBOutlet UITextField *textField;
	IBOutlet UILabel *label;
	
	IBOutlet MKMapView *mapView;
	
//	IBOutlet Map
	
	BOOL moveViewUp;
	CGFloat scrollAmount;
	
	NSString *callNumber;

	
	UITapGestureRecognizer *tgr;
	
	UILongPressGestureRecognizer *lpr;
	
	//////////////
	
	//UIBarButtonItem *selMapMethod;
	UISegmentedControl *selMapMethod; 
	
	BOOL JustAdded;
	BOOL HasRun;
	BOOL geoCoderResponded;
	
	MKPinAnnotationView *pin;
	PlaceMark *curPlacement;
	
	NSString *ChosenEmailAddress;
	
}
//@property (nonatomic, retain) IBAction UIButton *sendMessage;


@property (nonatomic, retain) MKReverseGeocoder *geoCoder;

@property (nonatomic, retain) IBOutlet UITextField *emailAddress;
//@property (nonatomic, retain) IBOutlet UITextField *textField;
@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSString *callNumber;
@property (nonatomic, retain) CLLocationManager *curLocation;
@property (nonatomic, retain) MKAnnotationView *curLocAnnotation;

@property (nonatomic, retain) MKPlacemark *curLocPlaceMark;

@property (nonatomic, retain) UITapGestureRecognizer *tgr;
@property (nonatomic, retain) UILongPressGestureRecognizer *lpr;

@property (nonatomic, retain) MKPinAnnotationView *pin;

@property (nonatomic, retain) PlaceMark *curPlacement;

-(void) keyboardWillShow:(NSNotification *)notif;


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;

- (IBAction) PressTheButton: (id) sender; //Button Link...

- (IBAction) PressedBarMenuButton: (id) sender;

- (IBAction) OpenContactsWindow;

- (IBAction) HIDEKB;

@property (nonatomic, retain) UISegmentedControl *selMapMethod;
- (IBAction) ButtonSelMapMethod: (id) sender;

//- (IBAction) SetToCurrentLocation: (id) sender; //Button Link...

- (void) scrollTheView:(BOOL)movedUp;
- (void) updateCallNumber;

//- (void) locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading;
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;

- (void) mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view;

- (void) panDone:(UIPanGestureRecognizer *)panRecognized;

@end

