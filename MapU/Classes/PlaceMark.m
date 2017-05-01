//
//  PlaceMark.m
//  MapU
//
//  Created by jono on 2012/08/15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PlaceMark.h"


@implementation PlaceMark

@synthesize coordinate,title, subtitle;

- (void) setTitle:(NSString *)strTitle{
	title = strTitle;	
}

- (void) setSubTitle:(NSString *)strSubTitle{
	subtitle = strSubTitle;
}
	
- (id) initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate = c;
	return self;
}

-(void) dealloc {
	[title release];
	[subtitle release];
   [super dealloc];
}
	
@end
