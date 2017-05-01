//
//  PlaceMark.h
//  MapU
//
//  Created by jono on 2012/08/15.
//  Copyright 2012 __MyCompanyName__. All rights reserved.


#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PlaceMark : NSObject <MKAnnotation> {
    
	CLLocationCoordinate2D coordinate;
	NSString *subtitle;
	NSString *title;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *title;

- (id) initWithCoordinate:(CLLocationCoordinate2D) coordinate;

//- (NSString *) subtitle;
//- (NSString *) title;

- (void) setTitle: (NSString *) strTitle;
- (void) setSubTitle: (NSString *) strSubTitle;
@end
