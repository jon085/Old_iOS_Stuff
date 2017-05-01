//
//  JonStreetViewTSTAppDelegate.h
//  JonStreetViewTST
//
//  Created by jono on 2012/08/28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JonStreetViewTSTViewController;

@interface JonStreetViewTSTAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JonStreetViewTSTViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JonStreetViewTSTViewController *viewController;

@end

