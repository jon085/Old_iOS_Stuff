//
//  EMailAssistant.h
//  TEST7
//
//  Created by jono on 2012/08/13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface EMailAssistant : UIViewController <MFMailComposeViewControllerDelegate> {

	
	MFMailComposeViewController *mailComposer; 

}

@property (nonatomic, retain) MFMailComposeViewController *mailComposer;

- (void) SendEmailTo: (NSString *) emTo MsgSubject: (NSString *) mSub MsgBody: (NSString *) mBody;
//- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;

@end
