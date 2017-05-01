//
//  TEST7AppDelegate.m
//  TEST7
//
//  Created by jono on 2012/08/06.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "TEST7AppDelegate.h"
#import "TEST7ViewController.h"

@implementation TEST7AppDelegate

@synthesize window;
@synthesize viewController;
//@synthesize curLocation;


	
#pragma mark -
#pragma mark Application lifecycle

- (void) applicationDidFinishLaunching:(UIApplication *)application {

	
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    	
    // Override point for customization after application launch.

    // Add the view controller's view to the window and display.
	
	NSLog(@"It Just started!");
	
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	NSLog(@"It Just Resigned the Activity!");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
	NSLog(@"It Just Entered in Background...");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
	NSLog(@"It Just Entered the Foreground!");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
	NSLog(@"It Just Became Active!");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
	NSLog(@"It's Terminating!");
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	NSLog(@"It Just got a Memory Warning!");
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
