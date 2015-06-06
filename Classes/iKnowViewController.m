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
			_sector08.alpha = 0.5;
			_sector01.alpha = 1.0;
			break;
		case 1:
			_sector01.alpha = 0.5;
			_sector02.alpha = 1.0;
			break;
		case 2:
			_sector02.alpha = 0.5;
			_sector03.alpha = 1.0;
			break;
		case 3:
			_sector03.alpha = 0.5;
			_sector04.alpha = 1.0;
			break;
		case 4:
			_sector04.alpha = 0.5;
			_sector05.alpha = 1.0;
			break;
		case 5:
			_sector05.alpha = 0.5;
			_sector06.alpha = 1.0;
			break;
		case 6:
			_sector06.alpha = 0.5;
			_sector07.alpha = 1.0;
			break;
		case 7:
			_sector07.alpha = 0.5;
			_sector08.alpha = 1.0;
			break;
		case 8:
			_sector08.alpha = 0.5;
			_sector01.alpha = 1.0;
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
	if (fabs(currentValue - lastValue) >= SHAKE_LEVEL) {
		guessCounter += 1 + genrand_int32() %3;
	}
    
	lastValue = currentValue;
}

@end
