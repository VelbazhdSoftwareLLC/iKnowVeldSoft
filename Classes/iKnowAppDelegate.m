//
//  iKnowAppDelegate.m
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iKnowAppDelegate.h"
#import "iKnowViewController.h"

@implementation iKnowAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after app launch
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
