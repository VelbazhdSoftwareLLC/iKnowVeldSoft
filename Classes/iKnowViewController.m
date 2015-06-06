//
//  iKnowViewController.m
//  iKnow
//
//  Created by Trifon Dimov on 3/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "iKnowViewController.h"
#import "mt.h"
#import <stdlib.h>
#import <time.h>
#import <AudioToolbox/AudioServices.h>

#define DM_PAUSED 1
#define DM_ROLLING 2
#define SHAKE_LEVEL 0.1
#define MIN_SECTORS_ROLL 30


@implementation iKnowViewController

SystemSoundID singleMoveSoundID;
SystemSoundID rollingEndSoundID;

/*@synthesize button,label;

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
}
*/



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	generator = [[OptionsGenerator alloc] init];
	moveCounter = 0;
	guessCounter = 0;
	dmState = DM_PAUSED;
	[NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(singleMove) userInfo:nil repeats:YES];
	
	NSString *path;
	NSURL *filepath;
	
	path = [NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath], @"/Pop.aiff"];
	filepath = [NSURL fileURLWithPath:path isDirectory:NO];
	AudioServicesCreateSystemSoundID((CFURLRef)filepath, &singleMoveSoundID);
	
	path = [NSString stringWithFormat:@"%@%@",[[NSBundle mainBundle] resourcePath], @"/Glass.aiff"];
	filepath = [NSURL fileURLWithPath:path isDirectory:NO];
	AudioServicesCreateSystemSoundID((CFURLRef)filepath, &rollingEndSoundID);

	[[UIAccelerometer sharedAccelerometer] setUpdateInterval:0.1];
	[[UIAccelerometer sharedAccelerometer] setDelegate:self];


}



/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	[generator release];
	AudioServicesDisposeSystemSoundID (singleMoveSoundID);
	AudioServicesDisposeSystemSoundID (rollingEndSoundID);
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[generator release];
    [super dealloc];
}

- (IBAction) buttonPressed:(id)sender {
	dmState = DM_ROLLING;
	//guessCounter = MIN_SECTORS_ROLL + rand() % 5;
	guessCounter = MIN_SECTORS_ROLL + genrand_int32() % 5;
	
}

- (void) singleMoveSound{
	AudioServicesPlaySystemSound(singleMoveSoundID);
}

- (void) rollingEndSound{
	AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
	AudioServicesPlaySystemSound(rollingEndSoundID);
}

- (void) singleMove {
	if(guessCounter == 0){
		return;
	}
		
	switch ( moveCounter ) {
		case 0:
			sector08.alpha = 0.5;
			sector01.alpha = 1.0;
			break;
		case 1:
			sector01.alpha = 0.5;
			sector02.alpha = 1.0;
			break;
		case 2:
			sector02.alpha = 0.5;
			sector03.alpha = 1.0;
			break;
		case 3:
			sector03.alpha = 0.5;
			sector04.alpha = 1.0;
			break;
		case 4:
			sector04.alpha = 0.5;
			sector05.alpha = 1.0;
			break;
		case 5:
			sector05.alpha = 0.5;
			sector06.alpha = 1.0;
			break;
		case 6:
			sector06.alpha = 0.5;
			sector07.alpha = 1.0;
			break;
		case 7:
			sector07.alpha = 0.5;
			sector08.alpha = 1.0;
			break;
		case 8:
			sector08.alpha = 0.5;
			sector01.alpha = 1.0;
			break;
	}
	
	moveCounter = (moveCounter+1) %8;
	guessCounter--;
	if(guessCounter == 0){
		dmState = DM_PAUSED;
		[self rollingEndSound];
	} else {
		[self singleMoveSound];
	}
}


-(void)acce:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration{
	static double lastValue = 0;
	static bool isFistTime = TRUE;
	
	if(isFistTime == TRUE){
		lastValue = sqrt(acceleration.x*acceleration.x + acceleration.y*acceleration.y + acceleration.z*acceleration.z);
		isFistTime = FALSE;
	}
	
	double currentValue = sqrt(acceleration.x*acceleration.x + acceleration.y*acceleration.y + acceleration.z*acceleration.z);
	if (abs(currentValue - lastValue) >= SHAKE_LEVEL) {
		//guessCounter += 1 + rand() %3;
		guessCounter += 1 + genrand_int32() %3;
	}
	lastValue = currentValue;
	
}


@end
