//
//  TEST7AppDelegate.h
//  TEST7
//
//  Created by jono on 2012/08/06.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TEST7ViewController;

@interface TEST7AppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TEST7ViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TEST7ViewController *viewController;

//@property (nonatomic, retain) CLLocation *curLocation;

@end

