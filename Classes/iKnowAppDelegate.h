//
//  iKnowAppDelegate.h
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iKnowViewController;

@interface iKnowAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    iKnowViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iKnowViewController *viewController;

@end

