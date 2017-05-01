//
//  EMailAssistant.m
//  TEST7
//
//  Created by jono on 2012/08/13.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "EMailAssistant.h"


@implementation EMailAssistant
@synthesize mailComposer;

- (void) viewDidLoad {
	[super viewDidLoad];	
}

- (void) SendEmailTo:(NSString *)emTo MsgSubject:(NSString *)mSub MsgBody:(NSString *)mBody {
	
	

//- (void) SendEmailTo:(NSString)emTo MsgSubject:(NSString)mSub MsgBody:(NSString)mBody {
	
	mailComposer  = [[MFMailComposeViewController alloc] init];
	
	mailComposer.mailComposeDelegate = self;
	
//	[mailComposer setModalPresentationStyle:UIModalPresentationStyle];
	[mailComposer setSubject: mSub];
	[mailComposer setMessageBody: mBody isHTML:NO];
	
	[self presentModalViewController:mailComposer animated:YES];
	
	NSLog(@"Did run Email...");
	NSLog(@"%@", emTo);
	NSLog(@"%@", mSub);
	NSLog(@"%@", mBody);
	
	[mailComposer release];
}

- (void) dealloc
{
	[mailComposer release];
	[super dealloc];
}


@end
